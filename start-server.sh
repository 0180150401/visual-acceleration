#!/bin/bash
# Simple local web server for previewing the site
# This allows videos and images to load properly

echo "Starting local web server..."
echo "Open your browser and go to: http://localhost:8000"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

cd "$(dirname "$0")"
python3 -m http.server 8000

