#!/bin/bash

echo "=== Checking If Kubernetes Works ==="
flux check --pre
echo ""

echo -n "GitHub Username: "
read -r GITHUB_USERNAME

echo -n "GitHub Token: "
read -rs GITHUB_TOKEN
echo ""

echo "What environment do you want to deploy?"
echo "1) Staging"
echo "2) Production"
echo -n "Select an option (1 or 2): "
read -r ENV_SELECTION

if [[ "$ENV_SELECTION" == "1" ]]; then
    DEPLOY_ENV="staging"
elif [[ "$ENV_SELECTION" == "2" ]]; then
    DEPLOY_ENV="production"
else
    echo "Invalid selection. Defaulting to staging."
    DEPLOY_ENV="staging"
fi

echo -n "SOPS Private Key: "
read -rs SOPS_PRIVATE_KEY
echo ""

echo "=== SETTING UP FLUX CD ==="
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=homelab \
  --branch=main \
  --path=./clusters/$DEPLOY_ENV \
  --personal
echo ""

echo "=== CREATING SOPS PRIVATE KEY ==="
kubectl create secret generic sops-age \
  --namespace=flux-system \
  --from-literal=age.agekey=$SOPS_PRIVATE_KEY
echo ""

echo "Done!"
