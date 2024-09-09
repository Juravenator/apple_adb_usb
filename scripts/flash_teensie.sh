#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail
IFS=$'\n\t\v'
cd `dirname "${BASH_SOURCE[0]:-$0}"`/..

if ! [ -x "$(command -v teensy-loader-cli)" ] && ! [ -x "$(command -v teensy_loader_cli)" ]; then
  echo 'Error: you need teensie-loader cli.' >&2
  echo 'try:' >&2
  echo 'sudo pacman -S teensy-loader-cli' >&2
  echo 'https://www.pjrc.com/teensy/loader_cli.html' >&2
  exit 1
else
  if [ -x "$(command -v teensy-loader-cli)" ]; then
    TEENSIE_LOADER="teensy-loader-cli"
  else
    TEENSIE_LOADER="teensy_loader_cli"
  fi
fi

BINARY=binaries/adb_usb_PIN${PORT}.hex

if [ -z "$BINARY" ]; then
  >&2 echo "No flashable binary found"
  exit 1
fi

echo "using binary $BINARY"
$TEENSIE_LOADER -mmcu=atmega32u4 -w -v $BINARY
