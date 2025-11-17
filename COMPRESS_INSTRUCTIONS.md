# Compressing Videos for GitHub

Your videos are too large for GitHub (over 100MB limit). Here's how to compress them:

## Step 1: Install ffmpeg

**On macOS:**
```bash
brew install ffmpeg
```

If you don't have Homebrew, install it first:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Step 2: Compress Videos

Once ffmpeg is installed, run:
```bash
./compress_videos.sh
```

This will create compressed versions of your videos.

## Step 3: Manual Compression (Alternative)

If you prefer to compress manually, use these commands:

**For each large video file:**

```bash
# Basic compression (target: ~50MB)
ffmpeg -i "essay/1/Screen Recording 2025-11-17 at 1.22.00 AM.mp4" \
  -vf "scale=1280:-1" \
  -c:v libx264 \
  -crf 28 \
  -preset medium \
  -c:a aac \
  -b:a 128k \
  "essay/1/Screen Recording 2025-11-17 at 1.22.00 AM_compressed.mp4"

# More aggressive compression if still too large (target: ~30MB)
ffmpeg -i "essay/1/Screen Recording 2025-11-17 at 1.22.00 AM.mp4" \
  -vf "scale=960:-1" \
  -c:v libx264 \
  -crf 32 \
  -preset slow \
  -c:a aac \
  -b:a 96k \
  "essay/1/Screen Recording 2025-11-17 at 1.22.00 AM_compressed.mp4"
```

## Step 4: Update HTML Files

After compression, update the HTML files to use the `*_compressed.mp4` versions.

## Compression Settings Explained

- `scale=1280:-1` - Resize to max 1280px width (maintains aspect ratio)
- `crf 28` - Quality setting (18-28 is good, higher = smaller file)
- `preset medium` - Encoding speed vs compression tradeoff
- `b:a 128k` - Audio bitrate (lower = smaller file)

