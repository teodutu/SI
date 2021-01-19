DESCRIPTION = "Christmas Tree"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PR = "r0"

SRC_URI = "file://display_tree.py"

do_install() {
	install -d ${D}/www/pages/cgi-bin
	install -m 0644 ${WORKDIR}/display_tree.py ${D}/www/pages/cgi-bin
}

FILES_${PN} += "/www"
