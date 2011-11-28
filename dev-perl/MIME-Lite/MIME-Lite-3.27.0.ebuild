# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=3.027
inherit perl-module

DESCRIPTION="Low-calorie MIME generator"

SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND="dev-perl/Email-Date-Format
	>=dev-perl/MIME-Types-1.28
	dev-perl/MailTools"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do

src_install(){
	perl-module_src_install
	insinto /usr/share/${PN}
	doins -r contrib || die
}
