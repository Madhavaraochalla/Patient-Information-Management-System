#!/bin/bash

set -e

CLONE_DIR="Patient-Information-Management-System"

echo "🗑️ Deleting resources created by deploy.sh..."

if [ -d "$CLONE_DIR" ]; then
    # Deleting resources that match labels or from YAML files
    kubectl delete -f "$CLONE_DIR" || echo "Some resources might already be deleted or not found."
else
    echo "⚠️ Directory $CLONE_DIR not found. Skipping kubectl delete."
fi

# If YAMLs do not specify the exact labels, we can target them by app name
echo "Deleting individual components created by deploy.sh..."

kubectl delete deployments -l app=postgres-db || echo "Postgres DB deployment already deleted."
kubectl delete deployments -l app=redis-db || echo "Redis DB deployment already deleted."
kubectl delete deployments -l app=result-app || echo "Result App deployment already deleted."
kubectl delete deployments -l app=voting-app || echo "Voting App deployment already deleted."
kubectl delete deployments -l app=worker-app || echo "Worker App deployment already deleted."

kubectl delete services -l app=postgres-db || echo "Postgres DB service already deleted."
kubectl delete services -l app=redis-db || echo "Redis DB service already deleted."
kubectl delete services -l app=result-app || echo "Result App service already deleted."
kubectl delete services -l app=voting-app || echo "Voting App service already deleted."
kubectl delete services -l app=worker-app || echo "Worker App service already deleted."

kubectl delete replicasets -l app=postgres-db || echo "Postgres DB replicaset already deleted."
kubectl delete replicasets -l app=redis-db || echo "Redis DB replicaset already deleted."
kubectl delete replicasets -l app=result-app || echo "Result App replicaset already deleted."
kubectl delete replicasets -l app=voting-app || echo "Voting App replicaset already deleted."
kubectl delete replicasets -l app=worker-app || echo "Worker App replicaset already deleted."

kubectl delete pods -l app=postgres-db || echo "Postgres DB pods already deleted."
kubectl delete pods -l app=redis-db || echo "Redis DB pods already deleted."
kubectl delete pods -l app=result-app || echo "Result App pods already deleted."
kubectl delete pods -l app=voting-app || echo "Voting App pods already deleted."
kubectl delete pods -l app=worker-app || echo "Worker App pods already deleted."

echo "🧹 Cleaning up cloned repository..."
rm -rf "$CLONE_DIR"

echo "✅ Cleanup complete! Only resources created by deploy.sh have been deleted."
