#!/usr/bin/env python3
"""
Helper script to automatically add images to essay HTML files.
Scans essay/N/ folder and updates essay/N.html with image tags.
"""
import os
import re
from pathlib import Path

def update_essay_html(essay_num):
    """Update essay HTML file with images from the corresponding folder."""
    essay_dir = Path(f'essay/{essay_num}')
    html_file = Path(f'essay/{essay_num}.html')
    
    if not essay_dir.exists():
        print(f"Folder {essay_dir} does not exist")
        return
    
    # Find all image files
    image_extensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp']
    images = []
    for ext in image_extensions:
        images.extend(essay_dir.glob(f'*{ext}'))
        images.extend(essay_dir.glob(f'*{ext.upper()}'))
    
    images = sorted(images, key=lambda x: x.name.lower())
    
    if not images:
        print(f"No images found in {essay_dir}")
        return
    
    # Read HTML file
    if not html_file.exists():
        print(f"HTML file {html_file} does not exist")
        return
    
    with open(html_file, 'r') as f:
        html_content = f.read()
    
    # Generate image tags
    image_tags = []
    for img in images:
        img_path = f"{essay_num}/{img.name}"
        image_tags.append(f'            <img src="{img_path}" alt="Essay {essay_num} - {img.stem}">')
    
    # Find the essay-images div and replace content
    pattern = r'(<div class="essay-images">)(.*?)(</div>)'
    
    replacement = f'\\1\n' + '\n'.join(image_tags) + '\n        \\3'
    
    new_html = re.sub(pattern, replacement, html_content, flags=re.DOTALL)
    
    # Write back
    with open(html_file, 'w') as f:
        f.write(new_html)
    
    print(f"Updated {html_file} with {len(images)} images:")
    for img in images:
        print(f"  - {img.name}")

if __name__ == '__main__':
    import sys
    essay_num = sys.argv[1] if len(sys.argv) > 1 else '1'
    update_essay_html(essay_num)

