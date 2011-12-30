# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit autotools eutils multilib

MY_P="${P}"

DESCRIPTION="A high-performance event loop/event model with lots of feature"
HOMEPAGE="http://software.schmorp.de/pkg/libev.html"
SRC_URI="http://dist.schmorp.de/libev/${MY_P}.tar.gz
	http://dist.schmorp.de/libev/Attic/${MY_P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64"
IUSE="elibc_glibc static-libs"

# Bug #283558
DEPEND="elibc_glibc? ( >=sys-libs/glibc-2.9_p20081201 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/4.01-gentoo.patch"

	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc Changes README || die
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libev.so.3.0.0
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libev.so.3.0.0
}