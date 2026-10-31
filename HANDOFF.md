# media-skills handoff

## Resume here

| # | Date | State | Next |
|---|---|---|---|
| 0 | 31.10.2026 (3) | Owner approved all four. ffmpeg-full + ImageMagick 7.1.2 installed: doctor ok, 42/42 tools. Tested: caption burn, timecoded frame, magick resize + text (needs `-font`). Public README + MIT LICENSE. Commits use the GitHub noreply email (repo-local git config). Public repo fvckdusan/media-skills. Owner's reels pipeline (narcissists-nation-social) stays as it is; the skill note says project pipelines win. | Nothing open. Next: use it; sync upstream when needed (read the diff first). |
| 1 | 31.10.2026 (2) | Fable review: 12 faults, all fixed. package.json now vendored (version 2.24.1 shows). Sync builds in a temp folder and swaps in only on success. Note warns against `npx ffmpeg-skill`. image-media owns WebM/VP9, RTMP and screen capture (ffmpeg-encoding.md restored). Still frames: `look.py --at T --no-timecode` + `sips` (tested). WebM encode tested. | Same owner decisions as row 1. |
| 2 | 31.10.2026 | Repo built. ffmpeg-skill vendored at a2c8433 with patches. image-media made. Both linked into ~/.claude/skills. media-tools plugin off. Test passed: cut (0 ms error), fit 9:16, check (reels), look (`--no-timecode`). doctor: 39/42 tools usable. | Owner decisions: `brew install ffmpeg-full` (caption, graphics, stabilize), `brew install imagemagick` (image-media), first commit, private GitHub remote. |

## Rules

- Never hand-edit `skills/ffmpeg-skill/`. Change `patches/`, then run `./sync-upstream.sh`.
- Run the scripts with `python3.12`.
- Before you commit a sync, read the upstream diff for new network calls or installers.
