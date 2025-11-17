#!/bin/bash
# Compress large video files for GitHub upload

echo "Compressing large videos..."
echo ""

cd "$(dirname "$0")/essay/1"

# List of videos that were too large for GitHub
videos=(
    "Screen Recording 2025-11-17 at 1.22.00 AM.mp4"
    "Screen Recording 2025-11-17 at 1.39.47 AM.mp4"
    "Screen Recording 2025-11-17 at 1.40.44 AM.mp4"
    "Screen Recording 2025-11-17 at 1.48.23 AM.mp4"
)

for video in "${videos[@]}"; do
    if [ -f "$video" ]; then
        size_mb=$(du -m "$video" | cut -f1)
        echo "Compressing: $video (${size_mb}MB)"
        
        # Create compressed version
        output="${video%.*}_compressed.mp4"
        
        # Compress: reduce to 1280px max width, maintain aspect ratio
        # CRF 28 = good quality/size balance
        ffmpeg -i "$video" \
            -vf "scale='min(1280,iw)':'min(720,ih)':force_original_aspect_ratio=decrease" \
            -c:v libx264 \
            -preset medium \
            -crf 28 \
            -c:a aac \
            -b:a 128k \
            -movflags +faststart \
            "$output" -y 2>&1 | grep -E "Duration|Stream|Output|error|File" | head -3 || true
        
        if [ -f "$output" ]; then
            new_size_mb=$(du -m "$output" | cut -f1)
            echo "  ✓ Created: $output (${new_size_mb}MB)"
            
            # If still too large, try more aggressive compression
            if [ "$new_size_mb" -gt 80 ]; then
                echo "  ⚠ Still large, trying more aggressive compression..."
                output2="${video%.*}_compressed2.mp4"
                ffmpeg -i "$video" \
                    -vf "scale='min(960,iw)':'min(540,ih)':force_original_aspect_ratio=decrease" \
                    -c:v libx264 \
                    -preset slow \
                    -crf 32 \
                    -c:a aac \
                    -b:a 96k \
                    -movflags +faststart \
                    "$output2" -y 2>&1 | grep -E "Duration|Stream|Output" | head -2 || true
                
                if [ -f "$output2" ]; then
                    final_size=$(du -m "$output2" | cut -f1)
                    echo "  ✓ Created: $output2 (${final_size}MB)"
                fi
            fi
        fi
        echo ""
    else
        echo "⚠ File not found: $video"
    fi
done

echo "Compression complete!"
echo ""
echo "Next: Update essay/1.html to use *_compressed.mp4 files"

