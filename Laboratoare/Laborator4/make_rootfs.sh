#! /bin/bash

IMAGE_PATH="../Laborator1/run_pi_qemu/2015-05-05-raspbian-wheezy-qemu.img"
ORIGINAL_SECTION_DIR="orig_tmp_dir"
CUSTOM_ROOTFS_DIR="rootfs_dir"
BOOT_FILE="boot_file"
ROOTFS="rootfs_file"
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

	sudo mount -o offset=$offset $IMAGE_PATH $ORIGINAL_SECTION_DIR
	sudo mount $file $CUSTOM_ROOTFS_DIR
	sudo cp -ra $ORIGINAL_SECTION_DIR/* $CUSTOM_ROOTFS_DIR

	echo "Done. $CUSTOM_ROOTFS_DIR contains:"
	ls $CUSTOM_ROOTFS_DIR

	echo "Unmounting directories"
	sudo umount $ORIGINAL_SECTION_DIR $CUSTOM_ROOTFS_DIR
}

echo "Creating boot file..."
dd if=/dev/zero of=$BOOT_FILE bs=1M count=100
mkfs -t vfat $BOOT_FILE

boot_sector_offset=$(file $IMAGE_PATH | cut -d ':' -f3 | cut -d ',' -f8 | cut -d ' ' -f3)
create_partition $boot_sector_offset $BOOT_FILE

echo "Creating rootfs..."
dd if=/dev/zero of=$ROOTFS bs=1M count=$((6 * 1024))
mkfs -t ext2 $ROOTFS

rootfs_sector_offset=$(file $IMAGE_PATH | cut -d ':' -f4 | cut -d ',' -f8 | cut -d ' ' -f3)
create_partition $rootfs_sector_offset $ROOTFS

echo "Creating complete rootfs file..."
dd if=/dev/zero of=$ROOTFS_IMAGE bs=1K count=$((6 * 1024 * 1024 + 100 * 1024 + 1))
fdisk $ROOTFS_IMAGE < fdisk_input.txt

dd if=$BOOT_FILE of=$ROOTFS_IMAGE bs=1K count=$((100 * 1024)) seek=1
dd if=$ROOTFS of=$ROOTFS_IMAGE bs=1K count=$((6 * 1024 * 1024)) seek=$((101 * 1024))

rmdir $ORIGINAL_SECTION_DIR $CUSTOM_ROOTFS_DIR
rm -f $BOOT_FILE $ROOTFS
echo "Cleaned up"
