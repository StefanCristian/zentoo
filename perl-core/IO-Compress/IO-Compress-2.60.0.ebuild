# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=PMQS
MODULE_VERSION=2.060
inherit perl-module

DESCRIPTION="allow reading and writing of compressed data"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="virtual/perl-Scalar-List-Utils
	>=virtual/perl-Compress-Raw-Zlib-${PV}
	>=virtual/perl-Compress-Raw-Bzip2-${PV}
	!perl-core/Compress-Zlib
	!perl-core/IO-Compress-Zlib
	!perl-core/IO-Compress-Bzip2
	!perl-core/IO-Compress-Base"
DEPEND="${RDEPEND}"
#	test? ( dev-perl/Test-Pod )"

SRC_TEST=parallel