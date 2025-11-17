#!/bin/bash
# Compress videos to reduce file size for GitHub (under 100MB)
# Usage: ./compress_videos.sh [video_file]

echo "Video Compression Tool for GitHub"
echo "================================="
echo ""

if [ -z "$1" ]; then
    echo "Usage: ./compress_videos.sh <video_file>"
    echo ""
    echo "Or compress all videos in essay folders:"
    echo "  find essay -name '*.mp4' -o -name '*.mov' | xargs -I {} ./compress_videos.sh {}"
    exit 1
fi

VIDEO="$1"
if [ ! -f "$VIDEO" ]; then
    echo "Error: File not found: $VIDEO"
    exit 1
fi

SIZE_MB=$(du -m "$VIDEO" | cut -f1)
echo "Original: $VIDEO (${SIZE_MB}MB)"

if [ "$SIZE_MB" -lt 50 ]; then
    echo "✓ File is already small enough for GitHub"
    exit 0
fi

OUTPUT="${VIDEO%.*}_compressed.mp4"
echo "Compressing..."

# Method 1: Moderate compression (target: 50-80MB)
ffmpeg -i "$VIDEO" \
    -vf "scale='min(1280,iw)':'min(720,ih)':force_original_aspect_ratio=decrease" \
    -c:v libx264 \
    -preset medium \
    -crf 28 \
    -c:a aac \
    -b:a 128k \
    -movflags +faststart \
    "$OUTPUT" -y 2>&1 | grep -E "Duration|Stream|error" | head -3

if [ -f "$OUTPUT" ]; then
    NEW_SIZE=$(du -m "$OUTPUT" | cut -f1)
    echo "✓ Created: $OUTPUT (${NEW_SIZE}MB)"
    
    if [ "$NEW_SIZE" -gt 100 ]; then
        echo "⚠ Still too large, trying more aggressive compression..."
        OUTPUT2="${VIDEO%.*}_compressed2.mp4"
        ffmpeg -i "$VIDEO" \
            -vf "scale='min(960,iw)':'min(540,ih)':force_original_aspect_ratio=decrease" \
            -c:v libx264 \
            -preset slow \
            -crf 32 \
            -c:a aac \
            -b:a 96k \
            -movflags +faststart \
            "$OUTPUT2" -y 2>&1 | grep -E "Duration|Stream|error" | head -2
        
        if [ -f "$OUTPUT2" ]; then
            FINAL_SIZE=$(du -m "$OUTPUT2" | cut -f1)
            echo "✓ Created: $OUTPUT2 (${FINAL_SIZE}MB)"
        fi
    fi
else
    echo "✗ Compression failed"
    exit 1
fi

echo ""
echo "Next: Update your HTML to use the compressed version"
