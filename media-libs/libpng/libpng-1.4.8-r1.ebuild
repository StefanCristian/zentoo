# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils libtool multilib

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz
	apng? ( mirror://sourceforge/${PN}-apng/${PN}-master/${PV}/${P}-apng.patch.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64"
IUSE="apng static-libs"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_prepare() {
	use apng && epatch "${WORKDIR}"/${P}-apng.patch
	elibtoolize
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ANNOUNCE CHANGES README TODO libpng-*.txt

	find "${ED}" -name '*.la' -exec rm -f {} +
}

pkg_preinst() {
	has_version ${CATEGORY}/${PN}:1.2 && return 0
	preserve_old_lib /usr/$(get_libdir)/libpng12$(get_libname 0)
}

pkg_postinst() {
	has_version ${CATEGORY}/${PN}:1.2 && return 0
	preserve_old_lib_notify /usr/$(get_libdir)/libpng12$(get_libname 0)
}
