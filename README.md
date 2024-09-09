# Apple Extended Keyboard ADB to USB converter

Done using the Teensy 2 and the wonderful folks at
https://github.com/tmk/tmk_keyboard

This repo is meant as a documentation of the process.
Some scripts `build_binary.sh` & `flash_teensie.sh` are provided that will
compile a binary and flash it to your teensy2, missing dependencies are
not automatically installed, but you get help getting them.

## Build and flash
```shell
make hex PORT=D0
make flash PORT=D0
```

## Hardware

This build has been verified on
- an original Teensy 2.0
- [a clone Atmega32u4 board](https://nl.aliexpress.com/item/1005006716616798.html)

## Wiring

https://github.com/tmk/tmk_keyboard/wiki/FAQ#pull-up-resistor

Pull-up resister:

    Keyboard       Conveter
                   ,------.
    5V------+------|VCC   |
            |      |      |
           [R]     |      |
            |      |      |
    Signal--+------|DATA  |
                   |      |
    GND------------|GND   |
                   `------'
    R: 1K Ohm resistor

## Port selection

Take note that the pin on your (dev) board may not match the naming scheme of the Atmega32u4 itself, check the datasheet.
