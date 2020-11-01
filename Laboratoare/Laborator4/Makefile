QEMU_SYSTEM = qemu-system-arm
KERNEL = ../../linux/arch/arm/boot/zImage
MACHINE = versatilepb
CPU = arm1176
ROOTFS = rootfs_image
NIC_MODEL = smc91c111
BRIDGE = virbr0
BRIDGE_ID = "SI_qemu_bridge"
ARGS = "root=/dev/sda2 console=ttyAMA0"

.PHONY: run clean

run: $(ROOTFS)
	sudo $(QEMU_SYSTEM) \
	-kernel $(KERNEL) \
	-M $(MACHINE) \
	-cpu $(CPU) \
	-drive file=$<,index=0,media=disk,format=raw \
	-append $(ARGS) \
	-net nic,model=$(NIC_MODEL),netdev=$(BRIDGE_ID) \
	-netdev bridge,br=$(BRIDGE),id=$(BRIDGE_ID) \
	-serial stdio

$(ROOTFS):
	./make_rootfs.sh

clean:
	rm -f $(ROOTFS)
