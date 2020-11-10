# SI
Sisteme Incorporate - UPB 2020-2021

## Laboratoare
### Laborator 1 - Setup QEMU

In fisierul `Laboratoare/Laborator1/run_pi_qemu/Makefile` se gaseste regula
`run` care lanseaza `qemu` pentru a emula RaspberryPi-ul folosit la laborator.
E nevoie ca in directorul de mai sus sa se gaseasca
[kernelul](https://drive.google.com/file/d/0B0lgiPZNMMyvaEtfN3V4VVBxRjg/view)
si
[sistemul de fisiere](https://drive.google.com/open?id=0B0lgiPZNMMyvOTFMakFuY1N2Q1E)
dezarhivat.

### Laborator 2 - Cross-compilare
Acelasi lucru ca in labul trecut, dar se foloseste variabila de mediu
`CROSS_COMPILE=arm-linux-gnueabihf-` pentru a compila programul `hello_world.c`
pentru arhitectura _ARM_.

### Laborator 3 - Compilare de Kernel
Se compileaza si se ruleaza kernelul
[Raspbian Wheezy 3.18](https://github.com/raspberrypi/linux/tree/rpi-3.18.y)
dupa ce i se aplica aceste 2 patch-uri:
- pentru a rula compila `ARMv6` pe platforma *Versatile PB*:
https://ocw.cs.pub.ro/courses/_media/si/laboratoare/linux-rpi-3.18.y-armv6.txt
- pentru modificarea configuratiei pentru platforma de mai sus:
https://ocw.cs.pub.ro/courses/_media/si/laboratoare/linux-rpi-3.18.y-qemu.txt

Compilearea genereaza imaginea de kernel `**/linux//arch/arm/boot/zImage`, iar
rootfs-ul este
[cel din primul laborator](https://drive.google.com/file/d/0B0lgiPZNMMyvOTFMakFuY1N2Q1E/view).

### Laborator 4 - Creare de rootfs
Se folosesc `dd` si `fdisk` pentru a se crea o imagine de rootfs ce contine 2
partitii copiate din imaginea disponibila
[aici](https://drive.google.com/open?id=0B0lgiPZNMMyvOTFMakFuY1N2Q1E), folosita
inca din primul laborator:
- in prima partitie se copiaza bootloaderul
- in cea de-a doua este rootfs-ul insusi

`fdisk` se foloseste pentru a crea tabela de partitionare a sistemului de
fisiere.

### Laborator 5 - Servicii web...
Niste puscarii in `html` si `php`. Nicio legatura cu nimic. Strict de umplutura.
Se configureaza in VM-ul ce ruleaza *Raspbian* un server care afisesaza data
curenta cand se apasa un buton si care afiseaza parametrii primiti de kernel
cand porneste si date despre dispozitivul unde e montat `/`.
