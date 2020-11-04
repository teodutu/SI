#! /bin/bash

ORIGINAL_IMAGE_PATH="../Laborator1/run_pi_qemu/2015-05-05-raspbian-wheezy-qemu.img"
ORIGINAL_SECTION_DIR="orig_tmp_dir"
CUSTOM_ROOTFS_DIR="rootfs_dir"
BOOT_TMP="boot_file"
ROOTFS_TMP="rootfs_file"
ROOTFS_IMAGE="rootfs_image"

if [ ! -d $ORIGINAL_SECTION_DIR ]; then
	mkdir $ORIGINAL_SECTION_DIR
fi

if [ ! -d $CUSTOM_ROOTFS_DIR ]; then
	mkdir $CUSTOM_ROOTFS_DIR
fi

echo -e "Creating complete rootfs file..."
dd if=/dev/zero of=$ROOTFS_IMAGE bs=1 count=0 seek=6G
fdisk $ROOTFS_IMAGE < fdisk_input.txt

echo -e "\nCreating boot and rootfs temporary files..."
dd if=/dev/zero of=$BOOT_TMP bs=1 count=0 seek=100M
mkfs -t vfat $BOOT_TMP

dd if=/dev/zero of=$ROOTFS_TMP bs=1 count=0 seek=6G
mkfs -t ext2 $ROOTFS_TMP

dd if=$BOOT_TMP of=$ROOTFS_IMAGE seek=2K
dd if=$ROOTFS_TMP of=$ROOTFS_IMAGE seek=202K

echo -e "\nMounting required partitions..."
original_rootfs_offset=$(file $ORIGINAL_IMAGE_PATH\
	| cut -d ":" -f4\
	| cut -d "," -f8\
	| cut -d " " -f3)
sudo mount -o offset=$((original_rootfs_offset * 512)) $ORIGINAL_IMAGE_PATH $ORIGINAL_SECTION_DIR
sudo mount -o offset=$((206848 * 512)) $ROOTFS_IMAGE $CUSTOM_ROOTFS_DIR

echo -e "\nCopying files between partitions..."
sudo cp -a $ORIGINAL_SECTION_DIR/* $CUSTOM_ROOTFS_DIR

echo -e "\nDone. $CUSTOM_ROOTFS_DIR contains:"
ls $CUSTOM_ROOTFS_DIR

echo -e "\nUnmounting directories"
sudo umount $ORIGINAL_SECTION_DIR $CUSTOM_ROOTFS_DIR

rmdir $ORIGINAL_SECTION_DIR $CUSTOM_ROOTFS_DIR
rm -f $BOOT_TMP $ROOTFS_TMP
echo -e "\nCleaned up. All good."
