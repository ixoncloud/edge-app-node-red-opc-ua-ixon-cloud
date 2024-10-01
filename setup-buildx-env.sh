#!/bin/bash

# Output executed commands and stop on errors
set -e -x

# Remove the existing instance if necessary
docker buildx rm secure-edge-pro || true

# Create and initialize the build environment
docker buildx create --name secure-edge-pro \
                     --config buildkitd-secure-edge-pro.toml
                     
# Set the active builder
docker buildx use secure-edge-pro
