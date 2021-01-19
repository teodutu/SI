FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "file://index.html \
	file://xmas_lighttpd.conf"

RDEPENDS_${PN} += "lighttpd-module-cgi \
	lighttpd-module-alias \
	lighttpd-module-rewrite \
	lighttpd-module-compress"

do_install_append() {
	install -d ${D}www/pages/cgi-bin
	install -m 0644 ${WORKDIR}/index.html ${D}/www/pages/
	install -m 0644 ${WORKDIR}/xmas_lighttpd.conf ${D}${sysconfdir}/lighttpd.conf
}
