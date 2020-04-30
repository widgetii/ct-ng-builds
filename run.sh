#!/usr/bin/env bash

mkdir -p x-tools
chmod o+rwx x-tools

docker run \
  -v $(pwd)/x-tools:/home/build/x-tools \
  widgetii/docker-ct-ng:latest \
  arm-unknown-linux-musleabi
