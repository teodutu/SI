QEMU_SYSTEM = qemu-system-arm
KERNEL = ../../zImage
MACHINE = versatilepb
CPU = arm1176
BASIC_FS = "../../../Lab_06/build/tmp/deploy/images/raspberrypi/rpi-basic-image-raspberrypi.ext3"
HELLO_FS = "../../../Lab_06/build/tmp/deploy/images/raspberrypi/rpi-hello-raspberrypi.ext3"
ARGS = "root=/dev/sda rw"

run:
	sudo $(QEMU_SYSTEM) \
	-kernel $(KERNEL) \
	-M $(MACHINE) \
	-cpu $(CPU) \
	-append $(ARGS) \
	-hda $(BASIC_FS)

run-hello:
	sudo $(QEMU_SYSTEM) \
	-kernel $(KERNEL) \
	-M $(MACHINE) \
	-cpu $(CPU) \
	-append $(ARGS) \
	-hda $(HELLO_FS)

