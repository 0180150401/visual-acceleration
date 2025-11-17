# Visual Acceleration Analysis

A static website showcasing visual essays examining how the modeling industry is a playground for accelerationist aesthetics and movement.

## Setup

This is a static website that can be viewed locally or published via GitHub Pages.

### Local Development

1. Start a local server:
   ```bash
   ./start-server.sh
   ```
   Or manually:
   ```bash
   python3 -m http.server 8000
   ```

2. Open your browser to: `http://localhost:8000`

## Publishing to GitHub Pages

1. Create a new repository on GitHub (e.g., `visual-acceleration`)

2. Push this code to GitHub:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git push -u origin main
   ```

3. Enable GitHub Pages:
   - Go to your repository on GitHub
   - Click **Settings** → **Pages**
   - Under **Source**, select **Deploy from a branch**
   - Choose **main** branch and **/ (root)** folder
   - Click **Save**

4. Your site will be available at:
   `https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/`

## Structure

- `index.html` - Main landing page
- `essay/` - Individual essay pages (1-7)
- `assets/css/styles.css` - Stylesheet
- `assets/images/` - Thumbnail images
- `.nojekyll` - Prevents Jekyll processing (required for GitHub Pages)
