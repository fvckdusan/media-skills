# media-skills

Two [Claude Code skills](https://docs.claude.com/en/docs/claude-code/skills) for working with video, audio and images on your own computer. No cloud, no API keys.

| Skill | Use it for |
|---|---|
| **ffmpeg-skill** | Editing video and audio: cut, join, make vertical, captions, overlays, remove silence, fix loudness, export for YouTube / Instagram / TikTok, and check the result. |
| **image-media** | Still images (resize, convert, crop, watermark, batch jobs) and the few video jobs ffmpeg-skill does not do: WebM, HLS/DASH streaming, RTMP live, screen capture. |

The two skills do not overlap. Each one says in its description which jobs belong to the other, so Claude picks the right one.

## Why this exists

I had two media skills that both claimed video work, so they competed. This repo keeps the best of each:

- **ffmpeg-skill** comes from [kajisho5/ffmpeg-skill](https://github.com/kajisho5/ffmpeg-skill). It has 42 tested scripts and a strict workflow: measure the file, edit without re-encoding where possible, then check and verify the output.
- **image-media** is the image and streaming part of the `media-processing` skill from [mrgoonie/claudekit-skills](https://github.com/mrgoonie/claudekit-skills).

## What you need

- **Python 3.10 or newer**
- **FFmpeg 6.1 or newer.** For captions and text overlays, FFmpeg needs `drawtext` and `libass`. On macOS the normal Homebrew `ffmpeg` does not have them, so install `ffmpeg-full`. The skill finds it on its own.
- **ImageMagick 7** for images

On macOS:

```bash
brew install ffmpeg-full imagemagick
```

## Install

```bash
git clone https://github.com/fvckdusan/media-skills.git
cd media-skills
./link.sh
```

`link.sh` links each skill into `~/.claude/skills`. It never replaces a real folder that is already there. Start a new Claude Code session to load the skills.

Check that everything works:

```bash
python3 skills/ffmpeg-skill/scripts/_contract.py doctor
```

It lists anything your FFmpeg build is missing and how to fix it.

## How to use it

Just ask Claude in plain words, for example:

- "Cut `talk.mp4` from 1:20 to 2:05."
- "Make `clip.mov` vertical for Reels and check it."
- "Resize every JPG in this folder to 1200 px wide."
- "Make an HLS stream from `video.mp4`."

## Keep ffmpeg-skill up to date

Do not run `npx ffmpeg-skill`: it replaces the link with a plain copy. Use this instead:

```bash
./sync-upstream.sh            # latest version
./sync-upstream.sh <commit>   # a specific version
```

The script downloads the upstream skill and puts back the local changes from `patches/`:

- a shorter description that sends image and streaming jobs to `image-media`
- a short local note with setup tips and rules

Look at what changed (`git diff`) before you commit an update. These scripts run on your computer.

The upstream version in use is in `skills/ffmpeg-skill/UPSTREAM`. Never edit `skills/ffmpeg-skill/` by hand; edit `patches/` and run the sync again.

## Changes to the original code

- **image-media:** new `SKILL.md`. Kept the image, WebM, streaming and reference material, and removed the video recipes that ffmpeg-skill now covers. In `scripts/batch_resize.py`, the height option is now `-H`, because `-h` clashed with `--help` and the script crashed at start.
- **ffmpeg-skill:** only the description and the local note change (see above). The scripts are untouched.

## Licence

- ffmpeg-skill: MIT, © kajisho5 (see `skills/ffmpeg-skill/LICENSE`)
- image-media: from claudekit-skills, marked `license: MIT` in its original `SKILL.md`
- Everything else in this repo: MIT
