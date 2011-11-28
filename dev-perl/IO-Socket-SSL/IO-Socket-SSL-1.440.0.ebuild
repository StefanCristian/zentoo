# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=SULLR
MODULE_VERSION=1.44
inherit perl-module

DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"

SLOT="0"
KEYWORDS="amd64"
IUSE="idn"

DEPEND=">=dev-perl/Net-SSLeay-1.33
	virtual/perl-Scalar-List-Utils
	idn? (
		|| (
			>=dev-perl/URI-1.50
			dev-perl/Net-LibIDN
		)
	)"
RDEPEND="${DEPEND}"

SRC_TEST="do"
