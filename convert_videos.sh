#!/bin/bash
# Convert .mov files to .mp4 for better browser compatibility
# Requires ffmpeg: brew install ffmpeg

cd "essay/1"

for mov_file in *.mov; do
    if [ -f "$mov_file" ]; then
        mp4_file="${mov_file%.mov}.mp4"
        echo "Converting: $mov_file -> $mp4_file"
        ffmpeg -i "$mov_file" -c:v libx264 -c:a aac -preset medium -crf 23 "$mp4_file"
    fi
done

echo "Conversion complete!"

