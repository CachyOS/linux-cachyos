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

# Check if tag already exists
if git tag -l "$TAG" | grep -q .; then
    echo "Error: tag '$TAG' already exists"
    exit 1
fi

# Show current state for confirmation
echo ""
echo "Tag:    $TAG"
echo "Branch: $(git branch --show-current)"
echo "Commit: $(git log -1 --oneline)"
echo ""
read -rp "Create signed tag? [y/N] " confirm
[[ "$confirm" == [yY] ]] || { echo "Aborted."; exit 0; }

git tag -s "$TAG" -m "CachyOS Linux ${VERSION}-${PKGREL}"

echo ""
echo "Tag '$TAG' created."
echo "Push with: git push origin $TAG"
