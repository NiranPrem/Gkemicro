#!/bin/bash
set -e

SERVICES=(
adservice
cartservice
checkoutservice
currencyservice
emailservice
frontend
paymentservice
productcatalogservice
recommendationservice
shippingservice
shoppingassistantservice
)

CHANGED=$(git diff --name-only HEAD~1 HEAD)

FOUND=()

for svc in "${SERVICES[@]}"
do
    if echo "$CHANGED" | grep -q "^src/$svc/"; then
        FOUND+=("$svc")
    fi
done

if [ ${#FOUND[@]} -eq 0 ]; then
    printf "%s\n" "${SERVICES[@]}"
else
    printf "%s\n" "${FOUND[@]}"
fi
