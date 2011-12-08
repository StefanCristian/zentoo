# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Unconditional dependency of gcc.  Keep this set to 0.
EAPI=0

inherit libtool

DESCRIPTION="A library for multiprecision complex arithmetic with exact rounding."
HOMEPAGE="http://mpc.multiprecision.org/"
SRC_URI="http://www.multiprecision.org/mpc/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=">=dev-libs/gmp-4.2.3
		>=dev-libs/mpfr-2.3.1"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}" || die
	elibtoolize # for FreeMiNT, bug #347317
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc "${S}"/{ChangeLog,NEWS,README,TODO}
}
