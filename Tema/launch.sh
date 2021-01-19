#! /bin/bash

QEMU_SYSTEM=qemu-system-arm
KERNEL=zImage
MACHINE=versatilepb
CPU=arm1176
ROOTFS=rpi-xmas-tree-raspberrypi.ext3
NIC_MODEL=smc91c111
BRIDGE=virbr0
BRIDGE_ID=SI_qemu_bridge

sudo $QEMU_SYSTEM \
-kernel $KERNEL \
-machine $MACHINE \
-cpu $CPU \
-hda $ROOTFS \
-append "root=/dev/sda rw console=tty0" \
-net nic,model=$NIC_MODEL,netdev=$BRIDGE_ID \
-netdev bridge,br=$BRIDGE,id=$BRIDGE_ID \
-serial stdio
