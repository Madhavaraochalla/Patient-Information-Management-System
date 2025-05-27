#!/bin/bash

set -e
#set -x
set -o pipefail

REPO_SSH_URL="git@github.com:Madhavaraochalla/Patient-Information-Management-System.git"
FILES=("SSH-push-code.sh" "Token-Push-code.sh" "delete.sh" "deploy.sh" "delete-repo.sh" "postgres-db-service.yml" "redis-db-service.yml" "voting-app-deployment.yml" "result-app-deployment.yml" "voting-app-service.yml" "postgres-Db-deployment.yml" "redis-Db-deployment.yml" "result-app-service.yml" "worker-app-deployment.yml")
FILES_TO_REMOVE=("Push-code.sh")

# Configure Git
git config --global core.autocrlf input

echo "🔍 Setting Git remote to SSH..."
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_SSH_URL"

echo "⬇️ Pulling latest changes..."
git pull origin master || true

echo "📁 Adding files to Git..."
for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        git add "$file"
        echo "✅ Added $file"
    fi
done

for file in "${FILES_TO_REMOVE[@]}"; do
    if [ -f "$file" ]; then
        git rm "$file"
        echo "🗑️ Removed $file"
    else
        echo "⚠️ Warning: $file does not exist."
    fi
done

commit_count=$(git rev-list --count HEAD)
changed_files=$(git diff --cached --name-only | tr '\n' ' ')
commit_message="Commit $commit_count: $changed_files"

if [ -n "$changed_files" ]; then
    git commit -m "$commit_message"
    echo "📦 Committed changes: $commit_message"
else
    echo "ℹ️ No changes to commit"
fi

# Push to GitHub
echo "🚀 Pushing to GitHub via SSH..."
git push -u origin master
