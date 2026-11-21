#!/usr/bin/env bash
# Symlink each skill in skills/ into ~/.claude/skills. Refuses to replace a real folder.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
TARGET="$HOME/.claude/skills"
mkdir -p "$TARGET"

for dir in "$REPO"/skills/*/; do
  name="$(basename "$dir")"
  link="$TARGET/$name"
  if [ -e "$link" ] && [ ! -L "$link" ]; then
    echo "skip $name: $link exists and is not a symlink" >&2
    continue
  fi
  ln -sfn "${dir%/}" "$link"
  echo "linked $name -> ${dir%/}"
done
