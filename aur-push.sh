#!/bin/bash
# aur-push.sh - Push package directories to their AUR repositories
# Usage: ./aur-push.sh [-n] [-y] [pkgdir...]

set -euo pipefail

usage() {
    cat <<EOF
Usage: $(basename "$0") [-n] [-y] [pkgdir...]

Push the committed state (HEAD) of each package directory to its AUR repo.
Without pkgdir arguments, every directory containing a .SRCINFO is checked;
packages without changes are skipped.

Options:
  -n    Dry run: prepare commits and show diffs, but don't push
  -y    Don't ask for confirmation before pushing
  -h    Show this help

Notes:
  - Only committed files are pushed; uncommitted changes are ignored
  - .SRCINFO is checked against 'makepkg --printsrcinfo' before pushing
  - AUR clones are cached in \${XDG_CACHE_HOME:-~/.cache}/aur-push
EOF
}

DRY_RUN=0
ASSUME_YES=0
while getopts "nyh" opt; do
    case "$opt" in
        n) DRY_RUN=1 ;;
        y) ASSUME_YES=1 ;;
        h) usage; exit 0 ;;
        *) usage; exit 1 ;;
    esac
done
shift $((OPTIND - 1))

REPO=$(git rev-parse --show-toplevel)
CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/aur-push"
HEAD_SHA=$(git -C "$REPO" rev-parse --short HEAD)
mkdir -p "$CACHE"

if [[ $# -gt 0 ]]; then
    PKGS=("${@%/}")
else
    mapfile -t PKGS < <(cd "$REPO" && git ls-files '*/.SRCINFO' | xargs -n1 dirname)
fi

push_pkg() {
    local pkg="$1" pkgbase ver aur

    if ! git -C "$REPO" cat-file -e "HEAD:$pkg/.SRCINFO" 2>/dev/null; then
        echo "==> $pkg: no committed .SRCINFO, skipping"
        return 0
    fi

    if [[ -n "$(git -C "$REPO" status --porcelain -- "$pkg")" ]]; then
        echo "==> $pkg: warning: uncommitted changes are not pushed"
    fi

    pkgbase=$(git -C "$REPO" show "HEAD:$pkg/.SRCINFO" | awk '/^pkgbase/ {print $3}')
    ver=$(git -C "$REPO" show "HEAD:$pkg/.SRCINFO" \
        | awk '/^\tpkgver/ {v=$3} /^\tpkgrel/ {r=$3} END {print v"-"r}')
    aur="$CACHE/$pkgbase"

    echo "==> $pkg ($pkgbase $ver)"

    # Fresh clone or reset the cached one to the AUR state
    if [[ -d "$aur/.git" ]]; then
        git -C "$aur" fetch -q origin
        if git -C "$aur" rev-parse -q --verify origin/master >/dev/null; then
            git -C "$aur" checkout -q -B master origin/master
            git -C "$aur" reset -q --hard origin/master
        fi
        git -C "$aur" clean -qfdx
    else
        git clone -q "ssh://aur@aur.archlinux.org/$pkgbase.git" "$aur"
    fi

    # Replace the tracked files with the committed package directory
    git -C "$aur" rm -rq --ignore-unmatch .
    git -C "$REPO" archive HEAD "$pkg" | tar -x --strip-components=1 -C "$aur"

    if ! diff -u "$aur/.SRCINFO" <(cd "$aur" && makepkg --printsrcinfo); then
        echo "==> $pkg: .SRCINFO is stale, run srcinfo.sh and commit first"
        return 1
    fi

    git -C "$aur" add -A
    if git -C "$aur" diff --cached --quiet; then
        echo "    up to date"
        return 0
    fi

    git -C "$aur" diff --cached --stat
    git -C "$aur" commit -q -m "$ver" -m "linux-cachyos@$HEAD_SHA"

    if [[ $DRY_RUN -eq 1 ]]; then
        echo "    dry run, not pushing (commit left in $aur)"
        return 0
    fi

    if [[ $ASSUME_YES -eq 0 ]]; then
        read -rp "    Push $pkgbase $ver to AUR? [y/N] " confirm
        if [[ "$confirm" != [yY] ]]; then
            echo "    skipped"
            return 0
        fi
    fi

    git -C "$aur" push -q origin master
    echo "    pushed"
}

failed=()
for pkg in "${PKGS[@]}"; do
    push_pkg "$pkg" || failed+=("$pkg")
done

if [[ ${#failed[@]} -gt 0 ]]; then
    echo ""
    echo "Failed: ${failed[*]}"
    exit 1
fi
