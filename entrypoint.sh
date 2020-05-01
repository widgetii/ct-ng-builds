#!/usr/bin/env bash

TOOLCHAIN=$1

if [[ -z "$TOOLCHAIN" ]]; then
  echo "Usage: $0 <toolchain-name>"
  echo -en "\te.g. 'arm-unknown-linux-musleabi'\n"
  exit 2
fi

cd $HOME/crosstools-ng
./ct-ng show-${TOOLCHAIN}
./ct-ng ${TOOLCHAIN}

# don't produce verbose output for CI platform
sed 's/CT_LOG_PROGRESS_BAR/# CT_LOG_PROGRESS_BAR/' -i .config

./ct-ng build

cd ~/x-tools
tar cfJ ${TOOLCHAIN}.tar.xz ${TOOLCHAIN}/*
