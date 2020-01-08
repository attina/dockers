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

docker pull attina/${IMAGE_NAME}:${IMAGE_TAG}
docker run -d -it --rm --name ${IMAGE_NAME}-${BUILD_NUMBER} attina/${IMAGE_NAME}:${IMAGE_TAG}
docker cp sn335x ${IMAGE_NAME}-${BUILD_NUMBER}:/home/xtools/
docker exec ${IMAGE_NAME}-${BUILD_NUMBER} make sdk
docker cp ${IMAGE_NAME}-${BUILD_NUMBER}:/home/xtools/buildroot/output/images ./
tar zcf ${IMAGE_NAME}-sdk.tar.gz images
docker stop ${IMAGE_NAME}-${BUILD_NUMBER}
