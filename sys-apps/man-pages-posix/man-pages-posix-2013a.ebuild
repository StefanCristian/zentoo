# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_P="${PN}-${PV:0:4}-${PV:0-1}"
DESCRIPTION="POSIX man-pages (0p, 1p, 3p)"
HOMEPAGE="http://www.kernel.org/doc/man-pages/"
SRC_URI="mirror://kernel/linux/docs/man-pages/${PN}/${MY_P}.tar.xz"

LICENSE="man-pages-posix-2013"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
RESTRICT="binchecks"

RDEPEND="virtual/man !<sys-apps/man-pages-3"

S=${WORKDIR}/${MY_P}

src_prepare() { :; }

src_configure() { :; }

src_compile() { :; }

src_install() {
	emake install DESTDIR="${ED}" || die
	dodoc man-pages-*.Announce README
}
