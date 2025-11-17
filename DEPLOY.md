# Deploying to GitHub Pages

## Step-by-Step Instructions

### 1. Create a GitHub Repository

1. Go to [GitHub.com](https://github.com) and sign in
2. Click the **+** icon in the top right → **New repository**
3. Name it (e.g., `visual-acceleration`)
4. Make it **Public** (required for free GitHub Pages)
5. **Don't** initialize with README, .gitignore, or license
6. Click **Create repository**

### 2. Push Your Code

Run these commands in your terminal (replace `YOUR_USERNAME` and `YOUR_REPO_NAME`):

```bash
cd "/Users/sebroda/Desktop/Visual Acceleration"

# Add the remote repository
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Push to GitHub
git push -u origin main
```

### 3. Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** (top menu)
3. Scroll down to **Pages** (left sidebar)
4. Under **Source**, select:
   - **Deploy from a branch**
   - Branch: **main**
   - Folder: **/ (root)**
5. Click **Save**

### 4. Access Your Site

Your site will be live at:
```
https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/
```

It may take a few minutes to deploy. You'll see a green checkmark when it's ready.

### 5. Update Your Site

Whenever you make changes:

```bash
git add .
git commit -m "Your commit message"
git push
```

Changes will automatically deploy to GitHub Pages within a few minutes.

## Troubleshooting

- **404 Error**: Wait a few minutes for GitHub Pages to build
- **Images/Videos not loading**: Make sure all file paths use absolute paths starting with `/`
- **Styling broken**: Check that `assets/css/styles.css` path is correct

