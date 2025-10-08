#!/bin/bash
# setup_demo.sh - Automated environment setup for app-modernisation-demo
#
# USE CASE: For users who want a single entry point to automate environment setup, including prerequisite checks,
# Minikube cluster provisioning, Konveyor deployment, and demo app deployment. This script is ideal for:
# - Non-technical users who prefer not to use Makefile directly
# - Automated CI/CD pipelines or onboarding scripts
# - Situations where you want extra checks or steps before/after running the Makefile
#
# If you already use the Makefile and have all prerequisites, you may not need this script.

set -e

# 1. Check/install prerequisites (optional, can prompt user)
command -v minikube >/dev/null 2>&1 || { echo "Please install minikube"; exit 1; }
command -v kubectl >/dev/null 2>&1 || { echo "Please install kubectl"; exit 1; }
command -v docker >/dev/null 2>&1 || { echo "Please install Docker"; exit 1; }

# 2. Start Minikube
minikube start --driver=docker --cpus=4 --memory=6144

# 3. Enable addons
minikube addons enable olm
minikube addons enable ingress

# 4. Deploy Konveyor (using Makefile if available)
if [ -f Makefile ]; then
  make setup
else
  echo "No Makefile found. Please deploy Konveyor manually."
fi

# 5. Deploy demo app (example: using kubectl)
kubectl apply -f assets/deployment.yaml
kubectl apply -f assets/configmap.yaml
kubectl apply -f assets/secret.yaml

echo "Setup complete! Access Konveyor and demo app via Minikube."
