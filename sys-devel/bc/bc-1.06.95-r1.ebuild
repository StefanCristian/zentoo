# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils flag-o-matic

DESCRIPTION="Handy console-based calculator utility"
HOMEPAGE="http://www.gnu.org/software/bc/bc.html"
SRC_URI="ftp://alpha.gnu.org/gnu/bc/${P}.tar.bz2
	mirror://gnu/bc/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="libedit readline static"

RDEPEND="readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )
	libedit? ( dev-libs/libedit )"
DEPEND="${RDEPEND}
	sys-devel/flex"

src_prepare() {
	epatch "${FILESDIR}"/${P}-void_uninitialized.patch #349339
}

src_configure() {
	local myconf
	if use readline ; then
		myconf="--with-readline --without-libedit"
	elif use libedit ; then
		myconf="--without-readline --with-libedit"
	else
		myconf="--without-readline --without-libedit"
	fi
	use static && append-ldflags -static
	econf ${myconf}
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS FAQ NEWS README ChangeLog
}
