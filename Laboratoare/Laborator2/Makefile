CROSS_COMPILE = arm-linux-gnueabihf-
CC = gcc
CFLAGS = -static
CPU = arm1176
QEMU_USER = qemu-arm
OBJ = hello_world

.PHONY: build clean

build: $(OBJ)

hello_world: $(OBJ).c
	$(CROSS_COMPILE)$(CC) $(CFLAGS) $^ -o $@

run: $(OBJ)
	$(QEMU_USER) -cpu $(CPU) $<

copy: $(OBJ)
	scp $< pi_qemu:

objdump: $(OBJ)
	$(CROSS_COMPILE)objdump -d $<

clean:
	rm -f $(OBJ)
