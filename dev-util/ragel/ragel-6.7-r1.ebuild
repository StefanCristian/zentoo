# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils autotools

DESCRIPTION="Compiles finite state machines from regular languages into executable code."
HOMEPAGE="http://www.complang.org/ragel/"
SRC_URI="http://www.complang.org/ragel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="vim-syntax"

DEPEND=""
RDEPEND=""

# We need to get the txl language in Portage to have the tests :(
RESTRICT=test

DOCS=( ChangeLog CREDITS README TODO )

src_prepare() {
	epatch "${FILESDIR}"/${P}+gcc-4.7.patch
	sed -i -e '/CXXFLAGS/d' configure.in || die

	eautoreconf
}

src_configure() {
	econf --docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_test() {
	cd "${S}"/test
	./runtests.in || die
}

src_install() {
	default

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins ragel.vim || die "doins ragel.vim failed"
	fi
}
