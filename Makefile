SHELL:=/bin/bash
.DEFAULT_GOAL := compile

ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

binaries/adb_usb_PIN${PORT}.hex:
	 scripts/build_binary.sh

.PHONY: hex
hex: binaries/adb_usb_PIN${PORT}.hex

.PHONY: flash
flash: hex
	scripts/flash_teensie.sh

.PHONY: clean
clean:
	rm -rf tmk_keyboard binaries
