#!/bin/bash
# tag-release.sh - Create signed CachyOS kernel tags in cachyos/linux
# Usage: ./tag-release.sh <kernel-version> [pkgrel]
# Example: ./tag-release.sh 6.19.3 1

set -euo pipefail

usage() {
    cat <<EOF
Usage: $(basename "$0") <kernel-version> [pkgrel]

Create a signed CachyOS release tag on the current branch.
Tags the HEAD commit of whatever branch is currently checked out.

Tag scheme: cachyos-<version>-<pkgrel>

  Kernel variant               Tag example
  ─────────────────────────────────────────────
  Stable initial               cachyos-6.19.0-1
  Stable point release         cachyos-6.19.3-1
  Stable re-spin               cachyos-6.19.3-2
  LTS                          cachyos-6.18.9-1
  RC                           cachyos-6.19-rc8-1

Arguments:
  kernel-version   Kernel version (required)
                   Accepts X.Y.Z (e.g. 6.19.3) or X.Y-rcN (e.g. 6.19-rc8)
  pkgrel           Package release number (default: 1)

Examples:
  $(basename "$0") 6.19.3
  $(basename "$0") 6.19.3 2
  $(basename "$0") 6.19-rc8

Notes:
  - Requires a GPG signing key configured via 'git config user.signingkey'
    or signing enabled globally with 'git config tag.gpgSign true'
  - Run this script from a checkout of github.com/CachyOS/linux
  - Topic branches must be merged (not squashed) into the release branch.
    The changelog is built from first-parent merge commits on top of the
    upstream base commit ("Linux X.Y.Z").
EOF
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
    usage
    exit 0
fi

VERSION="${1:-}"
PKGREL="${2:-1}"

if [[ -z "$VERSION" ]]; then
    usage
    exit 1
fi

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "Error: not inside a git repository"
    exit 1
fi

if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+(\.[0-9]+|-rc[0-9]+)$ ]]; then
    echo "Error: version must be X.Y.Z or X.Y-rcN (got: $VERSION)"
    exit 1
fi

if ! [[ "$PKGREL" =~ ^[0-9]+$ ]]; then
    echo "Error: pkgrel must be a positive integer (got: $PKGREL)"
    exit 1
fi

TAG="cachyos-${VERSION}-${PKGREL}"

# Extract major.minor ("6.19" from "6.19.3" or "6.19-rc8")
[[ "$VERSION" =~ ^([0-9]+\.[0-9]+) ]]
MAJOR_MINOR="${BASH_REMATCH[1]}"

if git tag -l "$TAG" | grep -q .; then
    echo "Error: tag '$TAG' already exists"
    exit 1
fi

# ---------------------------------------------------------------------------
# Changelog helpers
# ---------------------------------------------------------------------------

# Hash of the "Linux X.Y.Z" commit reachable from <ref>.
find_upstream_commit() {
    local version="$1" ref="$2"
    git log --format="%H %s" "$ref" 2>/dev/null \
        | awk -v tgt="Linux $version" '$0 ~ "^[0-9a-f]+ "tgt"$" {print $1; exit}'
}

# Most recent cachyos-<major.minor>-* tag. Works across stable rebases
# because it sorts by version name, not by ancestry.
find_prev_tag() {
    local major_minor="$1"
    git tag -l "cachyos-${major_minor}*" --sort=-v:refname 2>/dev/null | head -n1
}

# Extract the kernel version out of a "cachyos-<ver>-<pkgrel>" tag.
tag_to_version() {
    sed -E 's/^cachyos-(.+)-[0-9]+$/\1/' <<< "$1"
}

# Enumerate first-parent merge commits of topic branches on top of <upstream>
# reachable from <ref>. Emits "<merge-hash>\t<branch-name>" per line.
list_branch_merges() {
    local upstream="$1" ref="$2"
    [[ -z "$upstream" ]] && return 0
    git log --first-parent --merges --format="%H%x09%s" \
        "${upstream}..${ref}" 2>/dev/null \
        | sed -n "s/^\\([0-9a-f]\\+\\)\\t[Mm]erge branch '\\([^']\\+\\)'.*/\\1\\t\\2/p"
}

# Commits introduced by a merge (branch side), oldest first: "<short-hash> <subject>".
merge_side_commits() {
    git log --format="%h %s" --no-merges --reverse "${1}^1..${1}^2" 2>/dev/null
}

# Snapshot of branch composition at <ref>: "<branch>\t<subject>" lines.
# Used to diff two releases without relying on hashes (survives rebases).
snapshot_branches() {
    local upstream="$1" ref="$2"
    list_branch_merges "$upstream" "$ref" | while IFS=$'\t' read -r mhash branch; do
        merge_side_commits "$mhash" | while read -r _ subject; do
            printf '%s\t%s\n' "$branch" "$subject"
        done
    done
}

generate_changelog() {
    local version="$1" pkgrel="$2" major_minor="$3" prev_tag="$4"

    local upstream_hash
    upstream_hash=$(find_upstream_commit "$version" "HEAD")

    echo "## CachyOS Linux ${version}-${pkgrel}"
    echo ""
    echo "Based on Linux ${version}"
    [[ -n "$prev_tag" ]] && echo "Previous release: \`${prev_tag}\`"
    echo ""

    # --- Diff vs. previous release -----------------------------------------
    if [[ -n "$prev_tag" ]]; then
        local prev_version prev_upstream prev_snap cur_snap
        prev_version=$(tag_to_version "$prev_tag")
        prev_upstream=$(find_upstream_commit "$prev_version" "$prev_tag")
        prev_snap=$(snapshot_branches "$prev_upstream" "$prev_tag")
        cur_snap=$(snapshot_branches "$upstream_hash" "HEAD")

        local prev_branches cur_branches
        prev_branches=$(cut -f1 <<< "$prev_snap" | sort -u | sed '/^$/d')
        cur_branches=$(cut -f1 <<< "$cur_snap"  | sort -u | sed '/^$/d')

        echo "### Changes since \`${prev_tag}\`"
        echo ""

        if [[ "$prev_version" != "$version" ]]; then
            echo "- Rebased to upstream: \`${prev_version}\` → \`${version}\`"
        fi

        comm -13 <(echo "$prev_branches") <(echo "$cur_branches") \
            | sed '/^$/d;s/^/- Added branch: **/;s/$/**/'
        comm -23 <(echo "$prev_branches") <(echo "$cur_branches") \
            | sed '/^$/d;s/^/- Removed branch: **/;s/$/**/'

        while read -r b; do
            [[ -z "$b" ]] && continue
            local prev_set cur_set added dropped
            prev_set=$(awk -F'\t' -v B="$b" '$1==B {print $2}' <<< "$prev_snap" | sort)
            cur_set=$(awk -F'\t' -v B="$b" '$1==B {print $2}' <<< "$cur_snap"  | sort)
            added=$(comm -13 <(echo "$prev_set") <(echo "$cur_set") | sed '/^$/d')
            dropped=$(comm -23 <(echo "$prev_set") <(echo "$cur_set") | sed '/^$/d')
            if [[ -n "$added" || -n "$dropped" ]]; then
                echo "- Updated branch: **${b}**"
                [[ -n "$added"   ]] && sed 's/^/    - `+` /' <<< "$added"
                [[ -n "$dropped" ]] && sed 's/^/    - `-` /' <<< "$dropped"
            fi
        done < <(comm -12 <(echo "$prev_branches") <(echo "$cur_branches"))

        echo ""
    fi

    # --- Full branch listing -----------------------------------------------
    echo "### Applied branches"
    echo ""
    list_branch_merges "$upstream_hash" "HEAD" | while IFS=$'\t' read -r mhash branch; do
        echo "#### ${branch}"
        merge_side_commits "$mhash" | while read -r chash subject; do
            echo "- \`${chash}\` ${subject}"
        done
        echo ""
    done
}

# ---------------------------------------------------------------------------
# Main flow
# ---------------------------------------------------------------------------

PREV_TAG=$(find_prev_tag "$MAJOR_MINOR")

echo ""
echo "Tag:    $TAG"
echo "Branch: $(git branch --show-current)"
echo "Commit: $(git log -1 --oneline)"
[[ -n "$PREV_TAG" ]] && echo "Prev:   $PREV_TAG"
echo ""

echo "Generating changelog..."
CHANGELOG=$(generate_changelog "$VERSION" "$PKGREL" "$MAJOR_MINOR" "$PREV_TAG")

echo ""
echo "=== Changelog Preview ==="
echo "$CHANGELOG"
echo "========================="
echo ""

read -rp "Create signed tag? [y/N] " confirm
[[ "$confirm" == [yY] ]] || { echo "Aborted."; exit 0; }

git tag -s "$TAG" -m "$CHANGELOG"

echo ""
echo "Tag '$TAG' created."

read -rp "Push tag and create GitHub release? [y/N] " push_confirm
if [[ "$push_confirm" == [yY] ]]; then
    git push origin "$TAG"

    echo "Generating source tarball..."
    TARBALL="${TAG}.tar.gz"
    git archive --format=tar.gz --prefix="${TAG}/" "$TAG" > "$TARBALL"

    NOTES_FILE=$(mktemp --suffix=.md)
    echo "$CHANGELOG" > "$NOTES_FILE"

    echo "Creating GitHub release and uploading tarball..."
    REPO_URL=$(git remote get-url origin)
    REPO_SLUG=$(echo "$REPO_URL" | sed -E 's#(https://github\.com/|git@github\.com:)##;s#\.git$##')
    gh release create "$TAG" "$TARBALL" \
        --repo "$REPO_SLUG" \
        --title "CachyOS Linux ${VERSION}-${PKGREL}" \
        --notes-file "$NOTES_FILE" \
        --verify-tag

    rm -f "$TARBALL" "$NOTES_FILE"
    echo ""
    echo "Release created with uploaded tarball (served via GitHub's CDN)."
    echo "Download URL: https://github.com/CachyOS/linux/releases/download/${TAG}/${TARBALL}"
else
    echo "Push with: git push origin $TAG"
fi
