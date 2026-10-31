---
name: image-media
description: 'Process still images with ImageMagick (convert, resize, crop, batch mogrify, watermarks, text, image montages, effects, responsive sizes, identify), and the FFmpeg jobs ffmpeg-skill scripts do not cover: WebM/VP9/Opus encodes, HLS/DASH packaging and bitrate ladders, RTMP live streaming, screen capture. Not for editing video or audio files: cuts, captions, GIFs, still frames, exports and loudness go to ffmpeg-skill.'
license: MIT
---

# Image and Streaming Media

Still images with ImageMagick, and the FFmpeg jobs that `ffmpeg-skill` has no script for: WebM/VP9/Opus, HLS/DASH, RTMP live, screen capture. Video and audio editing belongs to `ffmpeg-skill`; do not use this skill for it.

Requires ImageMagick 7 (`magick`) for images. If `magick` is missing, say so; on macOS, use `sips` for a plain resize or format change.

## Rules

- Never overwrite the source. Write to a new file or `-path ./out` with `mogrify`.
- Test one file before a batch. Show it, then run the rest.
- Check the result with `magick identify -format "%f: %wx%h %b\n" OUT` and look at the image before reporting.

## Quick reference

```bash
magick in.png out.jpg                                            # convert
magick in.jpg -resize 800x600 out.jpg                            # fit inside, keep aspect
magick in.jpg -resize 200x200^ -gravity center -extent 200x200 t.jpg   # square thumbnail
magick in.jpg wm.png -gravity southeast -geometry +10+10 -composite out.jpg  # watermark
mogrify -path ./out -format jpg -quality 85 -strip *.png         # batch, separate folder
for w in 320 640 1024 1920; do magick in.jpg -resize ${w}x -quality 85 "in-${w}w.jpg"; done
```

Text (`-annotate`, `label:`) needs a font file on macOS, or it fails with "unable to read font": add `-font /System/Library/Fonts/Supplemental/Verdana.ttf` (or another `.ttf`).

Geometry: `800x600` fit, `800x600!` exact, `800x600^` fill (may crop), `800x` width only, `50%` scale.

Batch resize script: `python3.12 <skill-dir>/scripts/batch_resize.py --help`.

## HLS (video on demand)

```bash
ffmpeg -i in.mp4 -c:v libx264 -preset fast -crf 22 -g 48 \
  -c:a aac -b:a 128k -f hls -hls_time 6 -hls_playlist_type vod playlist.m3u8
```

Ladders, DASH, RTMP live and screen capture: `references/ffmpeg-streaming.md`.

## WebM (VP9 + Opus)

```bash
ffmpeg -i in.mp4 -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libopus out.webm
```

Two-pass and other codecs: `references/ffmpeg-encoding.md`. Check the result with `python3.12 <ffmpeg-skill-dir>/scripts/probe.py out.webm`.

## References

Open one only for a question you have:

- `references/imagemagick-editing.md` — formats, effects, transforms, text
- `references/imagemagick-batch.md` — mogrify, parallel batches, memory limits
- `references/ffmpeg-streaming.md` — HLS/DASH, ABR ladders, RTMP live, screen capture
- `references/ffmpeg-encoding.md` — VP9/WebM, two-pass, codec choice
- `references/format-compatibility.md` — which format and codec where
