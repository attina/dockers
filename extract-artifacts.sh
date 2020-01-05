#!/usr/bin/env bash

docker run --rm -u xtools -i -v ${PWD}:/artifacts \
attina/xtools-arm-cortex_a8_hf bash << COMMANDS
tar zcf x-tools.tar.gz x-tools
cp x-tools.tar.gz /artifacts
COMMANDS
