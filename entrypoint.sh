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
./ct-ng build
