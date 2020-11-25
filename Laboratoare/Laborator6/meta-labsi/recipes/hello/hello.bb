DESCRIPTION = "Hello World"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PR = "r0"

#TODO: scrieți în SRC_URI calea către fișierul dorit.
SRC_URI = "file://hello.c"

S = "${WORKDIR}"

TARGET_CC_ARCH += "${LDFLAGS}" 

do_compile() {
	${CC} ${WORKDIR}/hello.c -o ${WORKDIR}/hello
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/hello ${D}${bindir}
}
