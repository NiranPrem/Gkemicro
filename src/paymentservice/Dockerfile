# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0

ARG BUILDPLATFORM=linux/amd64

FROM --platform=$BUILDPLATFORM node:20-bookworm-slim AS builder

RUN apt-get update && \
    apt-get install -y python3 make g++ && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --omit=dev

COPY . .

FROM node:20-bookworm-slim

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY . .

EXPOSE 50051

ENTRYPOINT ["node","index.js"]
