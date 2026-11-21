> **This Mac** (local note, kept by the media-skills repo):
> - **A project's own media pipeline wins.** If the current project has its own scripts or docs for video, audio or captions (for example a build script, WhisperX word timings, Pillow-drawn captions), follow them and edit that code as the project says. Use this skill there only when asked, or for probe/check/look on the outputs. The "no raw ffmpeg outside `scripts/*.py`" rule below covers this skill's own jobs, not project code.
> - Run this skill's scripts with `python3.12`, not `python3` (system `python3` is 3.9, below the 3.10 minimum). Project scripts keep their own interpreter.
> - Never run `npx ffmpeg-skill`, even if `doctor` says so: it replaces the symlinked skill with a plain copy. Refresh with `./sync-upstream.sh` in `~/Projects/media-skills`, and edit `patches/` there, not this file.
> - With Homebrew's lean `ffmpeg`, `caption`, `graphics` and `stabilize` do not work, and `look.py` needs `--no-timecode`. `doctor` names the fix (`ffmpeg-full`).
> - Still frames from a video: `look.py INPUT --at T --no-timecode` (repeat `--at` for more), then `sips -s format jpeg -Z 320 FILE.png --out FILE.jpg` for a small JPG.
> - Tasks no script covers go to the `image-media` skill, not to raw ffmpeg here: WebM/VP9/Opus encodes, HLS/DASH, RTMP live, screen capture.
