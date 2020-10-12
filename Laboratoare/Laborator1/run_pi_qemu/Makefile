QEMU_SYSTEM = qemu-system-arm
KERNEL = zImage-qemu
MACHINE = versatilepb
CPU = arm1176
ROOTFS = 2015-05-05-raspbian-wheezy-qemu.img
NIC = smc91c111
ARGS = "root=/dev/sda2 console=ttyAMA0"

run:
	$(QEMU_SYSTEM) \
	-kernel $(KERNEL) \
	-M $(MACHINE) \
	-cpu $(CPU) \
	-drive file=$(ROOTFS),index=0,media=disk,format=raw \
	-append $(ARGS) \
	-device $(NIC) \
	-serial stdio
