# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="GNU utility to convert program --help output to a man page"
HOMEPAGE="http://www.gnu.org/software/help2man"
SRC_URI="mirror://gnu/help2man/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls elibc_glibc"

RDEPEND="dev-lang/perl
	elibc_glibc? ( nls? (
		dev-perl/Locale-gettext
	) )"
DEPEND="${RDEPEND}
	elibc_glibc? ( nls? (
		dev-perl/Locale-gettext
	) )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.36.4-respect-LDFLAGS.patch
	epatch "${FILESDIR}"/${PN}-1.38.2-build.patch
}

src_configure() {
	local myconf
	use elibc_glibc \
		&& myconf="${myconf} $(use_enable nls)" \
		|| myconf="${myconf} --disable-nls"
	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README THANKS
}
