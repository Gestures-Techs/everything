#!/bin/bash

# --- Configuration ---
GH_USER="RahulParmarRP"
GH_EMAIL="rahulparmar.n@gmail.com"
REPO_NAME=$(basename "$PWD")  # Use current folder name as repo name
GH_TOKEN=""  # <-- Set your GitHub token here if you already have it

ENV_FILE=".env"
GITIGNORE_FILE=".gitignore"

# --- Load or Prompt for GitHub Token ---
if [ -z "$GH_TOKEN" ]; then
  if [ -f "$ENV_FILE" ]; then
    echo "🔍 Loading GH_TOKEN from $ENV_FILE..."
    export $(grep GH_TOKEN "$ENV_FILE" | xargs)
  fi
fi

if [ -z "$GH_TOKEN" ]; then
  echo "🔐 No GitHub token found."
  read -sp "Enter your GitHub Personal Access Token: " GH_TOKEN
  echo ""
  echo "GH_TOKEN=$GH_TOKEN" > "$ENV_FILE"
  echo "✅ Token saved locally in $ENV_FILE (keep it private!)"
else
  echo "✅ Using GH_TOKEN from configuration."
fi

# --- Git Setup ---
echo "⚙️ Configuring Git user..."
git config user.name "$GH_USER"
git config user.email "$GH_EMAIL"

# --- Initialize repo if not already ---
if [ ! -d ".git" ]; then
  git init
  echo "✅ Initialized new Git repository."
fi

# --- .gitignore setup ---
if [ ! -f "$GITIGNORE_FILE" ]; then
  echo "# Ignore environment and setup files" > "$GITIGNORE_FILE"
fi

SCRIPT_NAME=$(basename "$0")
grep -qxF "$SCRIPT_NAME" "$GITIGNORE_FILE" || echo "$SCRIPT_NAME" >> "$GITIGNORE_FILE"
grep -qxF "$ENV_FILE" "$GITIGNORE_FILE" || echo "$ENV_FILE" >> "$GITIGNORE_FILE"

echo "📝 Updated .gitignore to exclude $SCRIPT_NAME and $ENV_FILE"

# --- Configure remote origin ---
git remote remove origin 2>/dev/null || true
git remote add origin "https://${GH_USER}:${GH_TOKEN}@github.com/${GH_USER}/${REPO_NAME}.git"
echo "✅ Remote origin set to GitHub repo: $REPO_NAME"

# --- Verify access ---
echo "🔎 Verifying GitHub access..."
if git ls-remote origin &>/dev/null; then
  echo "✅ GitHub connection successful!"
else
  echo "❌ Connection failed. Check your token or repo permissions."
fi

# --- Summary ---
echo ""
echo "🎯 Setup complete!"
echo "Repository: https://github.com/${GH_USER}/${REPO_NAME}"
echo "Next step: git add . && git commit -m 'Initial commit' && git push -u origin main"
