# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=KUBOTA
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Internationalized substitute of Text::Wrap"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="dev-perl/Text-CharWidth"
DEPEND="${RDEPEND}"

SRC_TEST="do"
