# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils autotools

DESCRIPTION="A library of routines for managing a database"
HOMEPAGE="http://fallabs.com/tokyocabinet/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug doc examples"

DEPEND="sys-libs/zlib
	app-arch/bzip2"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/fix_rpath.patch"
	sed -i \
		-e "/ldconfig/d" \
		-e "/DATADIR/d" Makefile.in || die
	# cflags fix - remove -O2 at end of line and -fomit-frame-pointer
	sed -i -e 's/-O3"$/"/' configure.in || die
	sed -i -e 's/-fomit-frame-pointer//' configure.in || die
	eautoreconf || die
}

src_configure() {
	# we use the "fastest" target without the -O3
	econf $(use_enable debug) --enable-off64 --enable-fastest
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	if use examples; then
		insinto /usr/share/${PF}/example
		doins example/* || die "Install failed"
	fi

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc/* || die "Install failed"
	fi
}

src_test() {
	emake -j1 check || die "Tests failed"
}
