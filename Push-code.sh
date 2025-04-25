#!/bin/bash

set -e

# Your GitHub username and repo name
GITHUB_USER="Madhavaraochalla"
REPO_NAME="Patient-Information-Management-System"

# Use the exported token (make sure it's exported before running the script)
# This assumes you've already done: export GITHUB_TOKEN=your_token_value
AUTH_REMOTE_URL="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${REPO_NAME}.git"

# Files to commit (Ensure these are valid files in the current directory)
FILES=("delete.sh" "deploy.sh" "Push-code.sh" "postgres-db-service.yml" "redis-db-service.yml" "voting-app-deployment.yml" "result-app-deployment.yml" "voting-app-service.yml" "postgres-Db-deployment.yml" "redis-Db-deployment.yml" "result-app-service.yml" "worker-app-deployment.yml")

# Files to remove (if needed)
FILES_TO_REMOVE=("") 

# Git config to fix line ending warnings
git config --global core.autocrlf input

# Check if repo exists and create if not
echo "Checking if repository $REPO_NAME exists on GitHub..."
repo_exists=$(curl -s -o /dev/null -w "%{http_code}" \
    -u "$GITHUB_USER:$GITHUB_TOKEN" \
    "https://api.github.com/repos/$GITHUB_USER/$REPO_NAME")

if [ "$repo_exists" -eq 404 ]; then
    echo "Repository not found. Creating repository on GitHub..."
    curl -s -X POST \
        -u "$GITHUB_USER:$GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        -d "{\"name\": \"$REPO_NAME\"}" \
        "https://api.github.com/user/repos"
else
    echo "Repository $REPO_NAME already exists on GitHub."
fi

# Initialize git repo if not already initialized
if [ ! -d .git ]; then
    echo "Initializing Git repository..."
    git init
    git commit --allow-empty -m "Initial commit"  # Ensure initial commit exists
fi

# Set or reset remote origin
git remote remove origin 2>/dev/null || true
git remote add origin "$AUTH_REMOTE_URL"

# Pull the latest changes from the repo to ensure we are up to date
echo "Pulling latest changes from GitHub..."
git pull origin master || echo "No changes to pull or already up-to-date."

# Add files
for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        git add "$file"
        echo "Added $file"
    else
        echo "Warning: $file does not exist."
    fi
done

# Remove files
for file in "${FILES_TO_REMOVE[@]}"; do
    if [ -f "$file" ]; then
        git rm --cached "$file" || git rm -f "$file"  # Force removal if the file has local modifications
        echo "Removed $file from repository."
    else
        echo "Warning: $file does not exist."
    fi
done

# Get commit count and create commit message
commit_count=$(git rev-list --count HEAD || echo "0")  # If no commits, count will be 0
commit_message="Commit $commit_count: $(git diff --cached --name-only | tr '\n' ' ')" 

# Commit changes with dynamic message
git commit -m "$commit_message" || echo "No changes to commit"

# Show added/removed files and commit ID
echo "Files added and committed:"
git diff --cached --name-only
commit_id=$(git log -1 --format=%H)
echo "Commit ID: $commit_id"

# Create and switch to a new branch
BRANCH="auto-deploy-branch"
git checkout -b $BRANCH || git checkout $BRANCH  # if branch already exists locally
echo "✅ Switched to branch: $BRANCH"

# Push to GitHub
echo "Pushing to GitHub repository $REPO_NAME..."
git branch -M master
git push -u origin master

# Show the commit ID of the pushed changes
echo "✅ Pushed scripts to GitHub repo: $REPO_NAME"
echo "Commit ID of pushed changes: $commit_id"
