#!/bin/sh
# post-buildroot.sh to patch buildroot to fit the customized board
# 2020, Gavin Gao <attinagaoxu@gmail.com>
: ${1?"Usage: $0 <buildroot dir>"}

BOARD_NAME="sn335x"

SRC_DIR="$(dirname $0)"
DST_DIR=$1

cp ${SRC_DIR}/${BOARD_NAME}_buildroot_defconfig ${DST_DIR}/configs/${BOARD_NAME}_defconfig
cp ${SRC_DIR}/${BOARD_NAME}-post-image.sh ${DST_DIR}/board/beaglebone/
chmod +x ${DST_DIR}/board/beaglebone/${BOARD_NAME}-post-image.sh
cp ${SRC_DIR}/${BOARD_NAME}-genimage.cfg ${DST_DIR}/board/beaglebone/
