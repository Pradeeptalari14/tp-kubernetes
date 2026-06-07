#!/usr/bin/env bash
set -euo pipefail
NS="${NAMESPACE:-production}"
echo "Deploying to: $NS"
kubectl apply -f examples/ -n "$NS" --recursive
kubectl rollout status deployment/my-app -n "$NS" --timeout=180s
kubectl get pods -l app=my-app -n "$NS"
echo "Done"