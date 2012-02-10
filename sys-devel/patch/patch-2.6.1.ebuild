# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic

DESCRIPTION="Utility to apply diffs to files"
HOMEPAGE="http://www.gnu.org/software/patch/patch.html"
SRC_URI="mirror://gnu/patch/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="static test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( sys-apps/ed )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# this file is missing from the tarball bug #300845
	cp "${FILESDIR}"/gnulib_strnlen.c gl/lib/strnlen.c || die
}

src_compile() {
	use static && append-ldflags -static

	local myconf=""
	[[ ${USERLAND} != "GNU" ]] && myconf="--program-prefix=g"
	econf ${myconf}

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
