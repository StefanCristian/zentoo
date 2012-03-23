# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MODULE_AUTHOR=GAAS
MODULE_VERSION=2.51
inherit perl-module

DESCRIPTION="MD5 message digest algorithm"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="virtual/perl-digest-base"
DEPEND="${RDEPEND}"

SRC_TEST=do
mydoc="rfc*.txt"
