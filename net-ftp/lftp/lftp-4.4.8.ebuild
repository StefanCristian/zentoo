# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools eutils libtool

DESCRIPTION="A sophisticated ftp/sftp/http/https/torrent client and file transfer program"
HOMEPAGE="http://lftp.yar.ru/"
SRC_URI="ftp://ftp.yars.free.net/pub/source/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

IUSE="+gnutls nls openssl socks5 +ssl"
LFTP_LINGUAS=( cs de es fr it ja ko pl pt_BR ru zh_CN zh_HK zh_TW )
IUSE+=" ${LFTP_LINGUAS[@]/#/linguas_}"

REQUIRED_USE="
	ssl? ( ^^ ( openssl gnutls ) )
"

RDEPEND="
	>=sys-libs/ncurses-5.1
	>=sys-libs/readline-5.1
	dev-libs/expat
	sys-libs/zlib
	socks5? (
		>=net-proxy/dante-1.1.12
		virtual/pam
	)
	ssl? (
		gnutls? ( >=net-libs/gnutls-1.2.3 )
		openssl? ( >=dev-libs/openssl-0.9.6 )
	)
"

DEPEND="
	${RDEPEND}
	=sys-devel/libtool-2*
	app-arch/xz-utils
	dev-lang/perl
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

DOCS=(
	BUGS ChangeLog FAQ FEATURES MIRRORS NEWS README README.debug-levels
	README.dnssec README.modules THANKS TODO
)

src_prepare() {
	epatch \
		"${FILESDIR}/${PN}-4.0.2.91-lafile.patch" \
		"${FILESDIR}/${PN}-4.3.5-autopoint.patch" \
		"${FILESDIR}/${PN}-4.3.8-gets.patch"
	sed -i configure.ac -e 's|^AM_CONFIG_HEADER|AC_CONFIG_HEADERS|g' || die
	eautoreconf
	elibtoolize # for Darwin bundles
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with gnutls) \
		$(use_with openssl openssl "${EPREFIX}"/usr) \
		$(use_with socks5 socksdante "${EPREFIX}"/usr) \
		--enable-packager-mode \
		--sysconfdir="${EPREFIX}"/etc/${PN} \
		--with-modules \
		--without-included-regex
}