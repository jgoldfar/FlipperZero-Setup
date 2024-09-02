#!/bin/sh

set -eu

REPOSITORY_ROOT_DIR="$(cd `dirname $0` && pwd)/.."
FIRMWARE_DIR="${REPOSITORY_ROOT_DIR}/firmware"

cd "$FIRMWARE_DIR"

git submodule update --recursive --init --force

rsync -r "${REPOSITORY_ROOT_DIR}/static-firmware/" firmware/

FBT_NO_SYNC=y ./fbt COMPACT=1 DEBUG=0 VERBOSE=1

echo "use './fbt COMPACT=1 DEBUG=0 VERBOSE=1 flash_usb' to install the firmware when the FlipperZero is connected"
