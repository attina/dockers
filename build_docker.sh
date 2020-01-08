#!/usr/bin/env bash
#
# Author: Gavin Gao <attinagaoxu@gmail.com>

if [ $# -eq 0 ] ; then
    echo "Please give a name for your docker image."
    exit 1
fi

if [ $# -gt 2 ] ; then 
    echo "Too many arguments."
    exit 1
fi

IMAGE_NAME=$1
IMAGE_TAG=latest

if  [ -z $2 ]; then
    IMAGE_TAG=$2;
fi

docker build --squash --compress --rm -t attina/${IMAGE_NAME}:${IMAGE_TAG} .
docker push attina/${IMAGE_NAME}:${IMAGE_TAG}