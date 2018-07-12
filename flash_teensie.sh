#!/bin/bash

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

if [ ! -z "$1" ]; then
  BINARY=$1;
elif [ -f tmk_keyboard/converter/adb_usb/adb_usb_teensy.hex ]; then
  BINARY="tmk_keyboard/converter/adb_usb/adb_usb_teensy.hex"
else
  BINARY="binaries/adb_usb_teensy.hex"
fi

echo "using binary $BINARY"
$TEENSIE_LOADER -mmcu=atmega32u4 -w -v $BINARY
