#!/bin/bash
set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <service>"
    exit 1
fi

SERVICE="$1"

PROJECT_ID="${PROJECT_ID:-new123456-501605}"
ARTIFACT_REGION="${ARTIFACT_REGION:-asia-south1}"
ARTIFACT_REPOSITORY="${ARTIFACT_REPOSITORY:-online-boutique}"

IMAGE="${ARTIFACT_REGION}-docker.pkg.dev/${PROJECT_ID}/${ARTIFACT_REPOSITORY}/${SERVICE}"

TAG="${GITHUB_SHA:-local}"

echo "========================================"
echo "Service      : ${SERVICE}"
echo "Image        : ${IMAGE}"
echo "Tag          : ${TAG}"
echo "========================================"

docker build \
    -t "${IMAGE}:${TAG}" \
    -t "${IMAGE}:latest" \
    "src/${SERVICE}"

echo
echo "Pushing ${IMAGE}:${TAG}"
docker push "${IMAGE}:${TAG}"

echo
echo "Pushing ${IMAGE}:latest"
docker push "${IMAGE}:latest"

echo
echo "========================================"
echo "${SERVICE} build completed successfully."
echo "========================================"
