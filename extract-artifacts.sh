#!/usr/bin/env bash


docker run --rm -i -v ${PWD}:/artifacts \
attina/xtools-sn335x bash << COMMANDS
make sdk
cd output
tar zcf images.tar.gz images
cp images.tar.gz /artifacts
COMMANDS
