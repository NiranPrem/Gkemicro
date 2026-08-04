#!/bin/bash

set -e

PROJECT_ID="new123456-501605"
REGION="asia-south1"
REPOSITORY="online-boutique"

IMAGE_PREFIX="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}"

echo "Configuring Docker authentication..."
gcloud auth configure-docker ${REGION}-docker.pkg.dev --quiet

declare -A SERVICES=(
  [frontend]="src/frontend"
  [cartservice]="src/cartservice/src"
  [checkoutservice]="src/checkoutservice"
  [currencyservice]="src/currencyservice"
  [emailservice]="src/emailservice"
  [paymentservice]="src/paymentservice"
  [productcatalogservice]="src/productcatalogservice"
  [recommendationservice]="src/recommendationservice"
  [shippingservice]="src/shippingservice"
  [adservice]="src/adservice"
  [loadgenerator]="src/loadgenerator"
)

for SERVICE in "${!SERVICES[@]}"; do
    DIR=${SERVICES[$SERVICE]}

    echo "========================================="
    echo "Building ${SERVICE}"
    echo "========================================="

    docker build \
        -t ${IMAGE_PREFIX}/${SERVICE}:latest \
        ${DIR}

    echo "Pushing ${SERVICE}"

    docker push ${IMAGE_PREFIX}/${SERVICE}:latest

    echo "${SERVICE} uploaded successfully"
    echo
done

echo "========================================="
echo "All images pushed successfully!"
echo "========================================="
