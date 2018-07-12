#!/bin/bash

if [ ! -d "tmk_keyboard" ]; then
  git clone https://github.com/tmk/tmk_keyboard.git
  cd tmk_keyboard
  # https://github.com/tmk/tmk_keyboard/commit/dd543150b45c8dc45a5837a6ce6c7d61c8525c52
  # this was the latest commit at the time of writing
  git checkout dd543150b45c8dc45a5837a6ce6c7d61c8525c52
  git apply ../patches/disable_mouse.patch
  git apply ../patches/set_port_f4.patch
  cd converter/adb_usb
else
  cd tmk_keyboard/converter/adb_usb
fi

if ! [ -x "$(command -v avr-gcc)" ]; then
  echo 'Error: you need avr-gcc.' >&2
  echo 'try:' >&2
  echo 'sudo apt-get install avr-libc' >&2
  echo 'sudo pacman -S avr-libc' >&2
  echo 'brew tap osx-cross/avr && brew install avr-gcc' >&2
  exit 1
fi

make clean
make -f Makefile.teensy
