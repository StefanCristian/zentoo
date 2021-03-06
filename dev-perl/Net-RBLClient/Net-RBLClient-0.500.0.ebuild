# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=ABLUM
MODULE_VERSION=0.5
inherit perl-module

DESCRIPTION="Net::RBLClient - Queries multiple Realtime Blackhole Lists in parallel"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="virtual/perl-Time-HiRes
	dev-perl/Net-DNS"

S=${WORKDIR}/RBLCLient-${MODULE_VERSION} # second capitialized 'l' is deliberate
