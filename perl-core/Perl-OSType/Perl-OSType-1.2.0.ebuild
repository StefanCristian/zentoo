# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=1.002
inherit perl-module

DESCRIPTION="Map Perl operating system names to generic types"

SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		>=virtual/perl-Test-Simple-0.88
	)"

SRC_TEST="do"
