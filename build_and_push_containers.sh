#!/bin/bash

# Output executed commands and stop on errors.
set -e -x

# Uncomment the following line should the edge gateway have been
# given a different IP address.
# docker buildx rm secure-edge-pro;

# Create and initialize the build environment.
docker buildx create --name secure-edge-pro \
                     --config buildkitd-secure-edge-pro.toml
docker buildx use secure-edge-pro

docker buildx build --platform linux/arm64/v8 --tag 192.168.140.1:5000/node-red-opc-ua:latest --push .
