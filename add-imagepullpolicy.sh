#!/bin/bash

for file in kubernetes-manifests/*.yaml
do
    awk '
    /image:/ && $0 !~ /redis:|busybox:/ {
        print
        sub(/image:.*/, "")
        print $0 "imagePullPolicy: IfNotPresent"
        next
    }
    {print}
    ' "$file" > "$file.tmp"

    mv "$file.tmp" "$file"
done

echo "Done."
