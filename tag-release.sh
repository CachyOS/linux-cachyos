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

# Validate we're in a git repo
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "Error: not inside a git repository"
    exit 1
fi

# Validate version format: X.Y.Z or X.Y-rcN
if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+(\.[0-9]+|-rc[0-9]+)$ ]]; then
    echo "Error: version must be X.Y.Z or X.Y-rcN (got: $VERSION)"
    exit 1
fi

# Validate pkgrel is a positive integer
if ! [[ "$PKGREL" =~ ^[0-9]+$ ]]; then
    echo "Error: pkgrel must be a positive integer (got: $PKGREL)"
    exit 1
fi

TAG="cachyos-${VERSION}-${PKGREL}"

# Extract major.minor (e.g. "6.19" from "6.19.3" or "6.19-rc8")
MAJOR_MINOR=$(echo "$VERSION" | grep -oP '^\d+\.\d+')

# Check if tag already exists
if git tag -l "$TAG" | grep -q .; then
    echo "Error: tag '$TAG' already exists"
    exit 1
fi

# ---------------------------------------------------------------------------
# Changelog generation
# ---------------------------------------------------------------------------

# Find the most recent cachyos-* tag that is an ancestor of HEAD
find_prev_tag() {
    git describe --tags --abbrev=0 --match "cachyos-*" 2>/dev/null || true
}

# Find the "Linux X.Y.Z" base commit in the current branch history
find_upstream_commit() {
    local version="$1"
    git log --format="%H %s" HEAD | while read -r hash subject; do
        if [[ "$subject" == "Linux ${version}" ]]; then
            echo "$hash"
            return
        fi
    done
}

# Generate a markdown changelog for the full set of patches applied on top of
# the upstream kernel base.  Every branch squash commit present on HEAD is
# listed with all of its individual commits (including short hash).
generate_changelog() {
    local prev_tag="$1"
    local version="$2"
    local pkgrel="$3"
    local major_minor="$4"

    local upstream_commit
    upstream_commit=$(find_upstream_commit "$version")

    # Always show all branches on top of upstream, not just the delta since
    # the previous tag.
    local squash_commits
    squash_commits=$(git log "${upstream_commit}..HEAD" --format="%H %s" --no-merges --reverse 2>/dev/null || true)

    {
        echo "## CachyOS Linux ${version}-${pkgrel}"
        echo ""
        echo "Based on Linux ${version}"
        [[ -n "$prev_tag" ]] && echo "Previous release: \`${prev_tag}\`"
        echo ""

        while IFS= read -r line; do
            [[ -z "$line" ]] && continue
            local hash="${line%% *}"
            local branch_name="${line#* }"

            # Skip upstream commits that contain spaces (e.g. "Linux 6.19.4",
            # "Merge tag ...", individual stable fixes between pkgrel bumps)
            [[ "$branch_name" == *" "* ]] && continue

            echo "### ${branch_name}"

            local branch_ref="origin/${major_minor}/${branch_name}"
            if [[ -n "$upstream_commit" ]] && git rev-parse --verify "$branch_ref" &>/dev/null 2>&1; then
                local commits
                commits=$(git log "${upstream_commit}..${branch_ref}" \
                    --format="- %h %s" --no-merges --reverse 2>/dev/null || true)
                if [[ -n "$commits" ]]; then
                    echo "$commits"
                else
                    echo "- (no individual commits found)"
                fi
            else
                # Fallback: show a file-change summary from the squash commit
                local stat
                stat=$(git diff-tree --stat "$hash" 2>/dev/null | tail -1 | xargs || true)
                [[ -n "$stat" ]] && echo "- ${hash:0:12} ${stat}" || echo "- (see git show ${hash})"
            fi
            echo ""
        done <<< "$squash_commits"
    }
}

# ---------------------------------------------------------------------------
# Main flow
# ---------------------------------------------------------------------------

PREV_TAG=$(find_prev_tag)

echo ""
echo "Tag:    $TAG"
echo "Branch: $(git branch --show-current)"
echo "Commit: $(git log -1 --oneline)"
[[ -n "$PREV_TAG" ]] && echo "Prev:   $PREV_TAG"
echo ""

echo "Generating changelog..."
CHANGELOG=$(generate_changelog "$PREV_TAG" "$VERSION" "$PKGREL" "$MAJOR_MINOR")

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

    # Write changelog to a temp file so gh can read it
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
