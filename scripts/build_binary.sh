#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail
IFS=$'\n\t\v'
cd `dirname "${BASH_SOURCE[0]:-$0}"`/..

mkdir -p binaries

if [ ! -d "tmk_keyboard" ]; then
  git clone https://github.com/tmk/tmk_keyboard.git
  cd tmk_keyboard
  # https://github.com/tmk/tmk_keyboard/commit/c215713f13796b73c0e9d202f380f5237f92bec6
  # this was the latest commit at the time of writing
  # git checkout c215713f13796b73c0e9d202f380f5237f92bec6
  # git checkout 7f7b7ffdc21361a9760fdc006b070787b1aaaa00
  git checkout abc61783dada52207b2ae1130af081caf186f135
  git submodule init
  git submodule update
  # git apply ../patches/set_port_f4.patch
  cd converter/adb_usb
else
  cd tmk_keyboard/converter/adb_usb
fi

PORT_BANK=$(echo ${PORT} | cut -c1-1)
PORT_NUM=$(echo ${PORT} | cut -c2-3)
sed -i -- "s|^#define ADB_PORT .*$|#define ADB_PORT        PORT${PORT_BANK}|" "config.h"
sed -i -- "s|^#define ADB_PIN .*$|#define ADB_PIN         PIN${PORT_BANK}|" "config.h"
sed -i -- "s|^#define ADB_DDR .*$|#define ADB_DDR         DDR${PORT_BANK}|" "config.h"
sed -i -- "s|^#define ADB_DATA_BIT .*$|#define ADB_DATA_BIT    ${PORT_NUM}|" "config.h"

if ! [ -x "$(command -v avr-gcc)" ]; then
   >&2 echo 'Error: you need avr-gcc.'
   >&2 echo 'try:'
   >&2 echo 'sudo apt-get install avr-libc'
   >&2 echo 'sudo pacman -S avr-libc'
   >&2 echo 'brew tap osx-cross/avr && brew install avr-gcc'
  exit 1
fi

TARGET="adb_usb_$PORT"

TARGET=$TARGET make clean
TARGET=$TARGET MCU=atmega32u4 make
cp $TARGET.hex ../../../binaries
