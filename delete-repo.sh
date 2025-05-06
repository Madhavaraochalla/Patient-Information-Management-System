#!/bin/bash

set -e

# GitHub username and repo name
GITHUB_USER="Madhavaraochalla"
REPO_NAME="Patient-Information-Management-System-1"

# Use the exported token (make sure it's exported before running the script)
# This assumes you've already done: export GITHUB_TOKEN=your_token_value
AUTH_REMOTE_URL="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${REPO_NAME}.git"

# Delete the GitHub repository
echo "Deleting GitHub repository $REPO_NAME..."

# Make API call to delete the repo
response=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE \
    -u "$GITHUB_USER:$GITHUB_TOKEN" \
    "https://api.github.com/repos/$GITHUB_USER/$REPO_NAME")

if [ "$response" -eq 204 ]; then
    echo "✅ Repository $REPO_NAME deleted successfully."
else
    echo "❌ Failed to delete repository. Response code: $response"
fi
