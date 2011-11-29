# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

XORG_DOC=doc
inherit xorg-2

DESCRIPTION="X.Org XExt protocol headers"

KEYWORDS="amd64"
IUSE=""

RDEPEND="!<x11-libs/libXext-1.0.99"
DEPEND="${RDEPEND}"

pkg_setup() {
	xorg-2_pkg_setup

	CONFIGURE_OPTIONS="
		$(use_with doc xmlto)
		--without-fop
	"
}
