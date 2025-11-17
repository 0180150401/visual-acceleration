# Video Compression Guide

## Quick Start

**ffmpeg is now installed!** You can compress videos using:

### Single Video
```bash
./compress_videos.sh "essay/1/your-video.mp4"
```

### All Videos in Essay Folders
```bash
find essay -type f \( -name "*.mp4" -o -name "*.mov" \) -exec ./compress_videos.sh {} \;
```

## Manual Compression Commands

### Moderate Compression (Target: 50-80MB)
```bash
ffmpeg -i "input.mp4" \
  -vf "scale='min(1280,iw)':'min(720,ih)':force_original_aspect_ratio=decrease" \
  -c:v libx264 \
  -preset medium \
  -crf 28 \
  -c:a aac \
  -b:a 128k \
  -movflags +faststart \
  "output_compressed.mp4"
```

### Aggressive Compression (Target: 20-50MB)
```bash
ffmpeg -i "input.mp4" \
  -vf "scale='min(960,iw)':'min(540,ih)':force_original_aspect_ratio=decrease" \
  -c:v libx264 \
  -preset slow \
  -crf 32 \
  -c:a aac \
  -b:a 96k \
  -movflags +faststart \
  "output_compressed.mp4"
```

## Settings Explained

- **scale** - Resizes video (maintains aspect ratio)
  - `1280x720` = HD quality
  - `960x540` = SD quality (smaller file)
  
- **crf** - Quality setting (lower = better quality, larger file)
  - `28` = Good balance
  - `32` = More compression
  
- **preset** - Encoding speed
  - `medium` = Faster encoding
  - `slow` = Better compression

## After Compression

1. Check file size: `du -h output_compressed.mp4`
2. Update HTML files to use `*_compressed.mp4`
3. Add compressed files to git: `git add essay/*/*_compressed.mp4`
4. Commit and push

