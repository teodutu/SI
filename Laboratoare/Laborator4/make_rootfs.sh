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

create_partition() {
	offset=$(($1 * 512))
	file=$2

	echo -e "\nMounting required partitions..."
	sudo mount -o offset=$offset $ORIGINAL_IMAGE_PATH $ORIGINAL_SECTION_DIR
	sudo mount $file $CUSTOM_ROOTFS_DIR

	echo -e "\nCopying files between partitions..."
	sudo cp -ra $ORIGINAL_SECTION_DIR/* $CUSTOM_ROOTFS_DIR

	echo -e "\nDone. $CUSTOM_ROOTFS_DIR contains:"
	ls $CUSTOM_ROOTFS_DIR

	echo -e "\nUnmounting directories"
	sudo umount $ORIGINAL_SECTION_DIR $CUSTOM_ROOTFS_DIR
}

echo "Creating boot file..."
dd if=/dev/zero of=$BOOT_TMP bs=1M count=100
mkfs -t vfat $BOOT_TMP

boot_sector_offset=$(file $ORIGINAL_IMAGE_PATH\
	| cut -d ":" -f3\
	| cut -d "," -f8\
	| cut -d " " -f3)
create_partition $boot_sector_offset $BOOT_TMP

echo -e "Creating rootfs..."
dd if=/dev/zero of=$ROOTFS_TMP bs=1M count=6K
mkfs -t ext2 $ROOTFS_TMP

rootfs_sector_offset=$(file $ORIGINAL_IMAGE_PATH\
	| cut -d ":" -f4\
	| cut -d "," -f8\
	| cut -d " " -f3)
create_partition $rootfs_sector_offset $ROOTFS_TMP

echo -e "\nCreating complete rootfs file..."
dd if=/dev/zero of=$ROOTFS_IMAGE bs=1K count=$((6 * 1024 * 1024 + 100 * 1024 + 1))
fdisk $ROOTFS_IMAGE < fdisk_input.txt

echo -e "\nCopying rootfs contents..."
dd if=$BOOT_TMP of=$ROOTFS_IMAGE bs=1K count=100K seek=1
dd if=$ROOTFS_TMP of=$ROOTFS_IMAGE bs=1K count=6M seek=$((101 * 1024))

rmdir $ORIGINAL_SECTION_DIR $CUSTOM_ROOTFS_DIR
rm -f $BOOT_TMP $ROOTFS_TMP
echo -e "\nCleaned up. All good."
