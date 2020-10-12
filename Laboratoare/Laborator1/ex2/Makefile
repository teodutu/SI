CC = arm-linux-gnueabihf-gcc
CFLAGS = -static
CPU = arm1176
QEMU_USER = qemu-arm

.PHONY: build clean

build: ex2

ex2: ex2.c
	$(CC) $(CFLAGS) $^ -o $@

run: ex2
	$(QEMU_USER) -cpu $(CPU) $<

clean:
	rm -f ex2
