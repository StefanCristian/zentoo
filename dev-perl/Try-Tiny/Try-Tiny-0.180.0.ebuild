# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=DOY
MODULE_VERSION=0.18
inherit perl-module

DESCRIPTION="Minimal try/catch with proper localization of $@"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

DEPEND="test? ( dev-perl/Sub-Name )"

SRC_TEST=do
