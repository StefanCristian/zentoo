# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=GAAS
MODULE_VERSION=2.13
inherit perl-module

DESCRIPTION="NIST SHA message digest algorithm"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="virtual/perl-digest-base"
RDEPEND="${DEPEND}"

SRC_TEST="do"
