# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils

DESCRIPTION="Utility for controlling IPMI enabled devices."
HOMEPAGE="http://ipmitool.sf.net/"
DEBIAN_PR="5ubuntu1"
DEBIAN_P="${P/-/_}"
DEBIAN_PF="${DEBIAN_P}-${DEBIAN_PR}"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	https://launchpad.net/ubuntu/+archive/primary/+files/${DEBIAN_PF}.diff.gz"
#IUSE="freeipmi openipmi"
IUSE="openipmi"
SLOT="0"
KEYWORDS="amd64"
LICENSE="BSD"

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}
		openipmi? ( sys-libs/openipmi )
		virtual/os-headers"
		#freeipmi? ( sys-libs/freeipmi )
# ipmitool CAN build against || ( sys-libs/openipmi sys-libs/freeipmi )
# but it doesn't actually need either.

src_prepare() {
	epatch "${DISTDIR}"/${DEBIAN_PF}.diff.gz
	for p in $(cat debian/patches/series) ; do
		epatch debian/patches/$p
	done
}

src_configure() {
	# - LIPMI and BMC are the Solaris libs
	# - OpenIPMI is unconditionally enabled in the configure as there is compat
	# code that is used if the library itself is not available
	# FreeIPMI does build now, but is disabled until the other arches keyword it
	#	`use_enable freeipmi intf-free` \
	econf \
		--enable-ipmievd \
		--enable-ipmishell \
		--enable-intf-lan \
		--enable-intf-lanplus \
		--enable-intf-open \
		--disable-intf-free \
		--disable-intf-imb \
		--disable-intf-lipmi \
		--disable-intf-bmc \
		--disable-internal-md5 \
		--with-kerneldir=/usr --bindir=/usr/sbin \
		|| die "econf failed"
	# Fix linux/ipmi.h to compile properly. This is a hack since it doesn't
	# include the below file to define some things.
	echo "#include <asm/byteorder.h>" >>config.h
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PACKAGE="${PF}" install || die "emake install failed"

	into /usr
	dosbin contrib/bmclanconf
	rm -f "${D}"/usr/share/doc/${PF}/COPYING
	docinto contrib
	cd "${S}"/contrib
	dodoc collect_data.sh create_rrds.sh create_webpage_compact.sh create_webpage.sh README

	newinitd "${FILESDIR}"/${PN}-1.8.9-ipmievd.initd ipmievd
	newconfd "${FILESDIR}"/${PN}-1.8.9-ipmievd.confd ipmievd
}
