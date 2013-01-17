# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

XORG_DOC=doc
inherit xorg-2

DESCRIPTION="X.Org Xfont library"

KEYWORDS="amd64"
IUSE="bzip2 ipv6 truetype"

RDEPEND="x11-libs/xtrans
	x11-libs/libfontenc
	truetype? ( >=media-libs/freetype-2 )
	bzip2? ( app-arch/bzip2 )
	x11-proto/xproto
	x11-proto/fontsproto"
DEPEND="${RDEPEND}"

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable ipv6)
		$(use_enable doc devel-docs)
		$(use_with doc xmlto)
		$(use_with bzip2)
		$(use_enable truetype freetype)
		--without-fop
	)
	xorg-2_src_configure
}

pkg_postinst() {
	xorg-2_pkg_postinst
	if ! use truetype; then
		elog "truetype support is disabled, non-Xft applications might not display truetype fonts."
	fi
}