# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit xorg-2

DESCRIPTION="X.Org Xcursor library"

KEYWORDS="amd64"
IUSE=""

RDEPEND=">=x11-libs/libXrender-0.8.2
	x11-libs/libXfixes
	x11-libs/libX11"
DEPEND="${RDEPEND}"

XORG_CONFIGURE_OPTIONS=(
	--with-icondir=/usr/share/cursors/xorg-x11
	--with-cursorpath='~/.cursors:~/.icons:/usr/local/share/cursors/xorg-x11:/usr/local/share/cursors:/usr/local/share/icons:/usr/local/share/pixmaps:/usr/share/cursors/xorg-x11:/usr/share/cursors:/usr/share/pixmaps/xorg-x11:/usr/share/icons:/usr/share/pixmaps'
)