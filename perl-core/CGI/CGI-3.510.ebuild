# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MY_PN=${PN}.pm
MODULE_AUTHOR=MARKSTOS
MODULE_VERSION=3.51
inherit perl-module

DESCRIPTION="Simple Common Gateway Interface Class"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

#DEPEND="dev-lang/perl"
#	dev-perl/FCGI" #236921

SRC_TEST="do"
