#!/bin/bash

# Exit on any error
set -e

REPO_URL="git@github.com:Madhavaraochalla/Patient-Information-Management-System.git"
CLONE_DIR="Patient-Information-Management-System"

echo "Starting Minikube..."
#minikube start

echo "Cloning repository..."
if [ -d "$CLONE_DIR" ]; then
    echo "Directory already exists. Pulling latest changes..."
    cd "$CLONE_DIR"
    git pull
else
    git clone "$REPO_URL"
    cd "$CLONE_DIR"
fi

echo "Deploying to Minikube..."
kubectl apply -f .

echo "Application deployed!"

# Show status of pods, deployments, and replica sets
echo
echo "🔍 Kubernetes Resources Status:"
echo "--------------------------------"
kubectl get pods
echo "--------------------------------"
kubectl get deployments
echo "--------------------------------"
kubectl get rs
