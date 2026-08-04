#!/bin/bash
set -e

REGISTRY="asia-south1-docker.pkg.dev/new123456-501605/online-boutique"

declare -A IMAGES=(
  ["image: adservice"]="image: ${REGISTRY}/adservice:latest"
  ["image: cartservice"]="image: ${REGISTRY}/cartservice:latest"
  ["image: checkoutservice"]="image: ${REGISTRY}/checkoutservice:latest"
  ["image: currencyservice"]="image: ${REGISTRY}/currencyservice:latest"
  ["image: emailservice"]="image: ${REGISTRY}/emailservice:latest"
  ["image: frontend"]="image: ${REGISTRY}/frontend:latest"
  ["image: loadgenerator"]="image: ${REGISTRY}/loadgenerator:latest"
  ["image: paymentservice"]="image: ${REGISTRY}/paymentservice:latest"
  ["image: productcatalogservice"]="image: ${REGISTRY}/productcatalogservice:latest"
  ["image: recommendationservice"]="image: ${REGISTRY}/recommendationservice:latest"
  ["image: shippingservice"]="image: ${REGISTRY}/shippingservice:latest"
)

for file in kubernetes-manifests/*.yaml; do
    echo "Updating $file"

    for old in "${!IMAGES[@]}"; do
        new="${IMAGES[$old]}"
        sed -i "s|$old|$new|g" "$file"
    done
done

echo
echo "====================================="
echo "All Kubernetes manifests updated."
echo "====================================="
