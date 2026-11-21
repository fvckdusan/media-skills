#!/usr/bin/env bash
# Refresh skills/ffmpeg-skill from upstream and re-apply the local patches.
# Usage: ./sync-upstream.sh [git-ref]   (default: main)
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
REF="${1:-main}"
URL="https://github.com/kajisho5/ffmpeg-skill.git"
DEST="$REPO/skills/ffmpeg-skill"
TMP="$(mktemp -d)"
OUT="$TMP/out"
trap 'rm -rf "$TMP"' EXIT

git clone -q "$URL" "$TMP/src"
git -C "$TMP/src" checkout -q "$REF"
SHA="$(git -C "$TMP/src" rev-parse HEAD)"

# Same payload as upstream's published npm package ("files" in package.json).
# package.json is needed at runtime: the scripts read the skill version from it.
mkdir -p "$OUT/references" "$OUT/docs"
cd "$TMP/src"
cp -R scripts templates mcp SKILL.md README.md LICENSE package.json "$OUT/"
cp references/scripts.md references/devices.md references/ci-platform-pitfalls.md references/gotchas.md "$OUT/references/"
cp docs/contract.md "$OUT/docs/"

# Patch: short description in the frontmatter, local note after it.
python3.12 - "$OUT/SKILL.md" "$REPO/patches" <<'PY'
import pathlib, sys
skill, patches = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
desc = (patches / "ffmpeg-skill.description.txt").read_text().strip().replace("'", "''")
note = (patches / "ffmpeg-skill.note.md").read_text().strip()
lines = skill.read_text().split("\n")
assert lines[0] == "---", "SKILL.md frontmatter changed upstream"
end = lines.index("---", 1)
idx = [i for i in range(1, end) if lines[i].startswith("description:")]
assert len(idx) == 1, "description line not found"
assert end == idx[0] + 1 or not lines[idx[0] + 1].startswith((" ", "\t")), "description is a multi-line block upstream"
lines[idx[0]] = f"description: '{desc}'"
lines[end + 1:end + 1] = ["", note]
skill.write_text("\n".join(lines))
PY

echo "$SHA" > "$OUT/UPSTREAM"

# Replace the live copy only after every step succeeded.
rm -rf "$DEST"
mv "$OUT" "$DEST"
echo "ffmpeg-skill synced to $SHA"
