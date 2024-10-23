BUILD_DIR=build
BOOTLOADER=$(BUILD_DIR)/bootloader/bootloader.o
OS=$(BUILD_DIR)/os/os
DISK_IMG=disk.img

all: bootdisk

.PHONY: bootloader os

bootloader:
	make -C bootloader

os:
	make -C os

bootdisk:  bootloader os
	# @echo "size is $(size)"
	# @echo "count is $(count)"
	dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
	dd conv=notrunc if=$(BOOTLOADER) of=$(DISK_IMG) bs=512 count=1 seek=0
	dd conv=notrunc if=$(OS) of=$(DISK_IMG) bs=512 count=1 seek=1
	dd conv=notrunc if=$(OS) of=$(DISK_IMG) bs=512 count=$$(($(shell stat --printf="%s" $(OS))/512)) seek=1

qemu:
	qemu-system-i386 -machine q35 -fda $(DISK_IMG) -gdb tcp::26000 -S

clean:
	make -C bootloader clean
	make -C os clean