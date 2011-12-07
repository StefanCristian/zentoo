# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit xorg-2

DESCRIPTION="create an index of X font files in a directory"

KEYWORDS="amd64"
IUSE=""

RDEPEND="x11-apps/mkfontscale"
DEPEND="${RDEPEND}"