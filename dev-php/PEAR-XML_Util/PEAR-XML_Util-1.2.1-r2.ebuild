# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

MY_PN="${PN/PEAR-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="XML utility class"

LICENSE="PHP-2.02"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
SRC_URI="http://pear.php.net/get/${MY_P}.tgz"

DEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )
		>=dev-php/PEAR-PEAR-1.8.1"
PDEPEND="dev-php/pear"

HOMEPAGE="http://pear.php.net/package/XML_Util"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /usr/share/php/XML
	doins Util.php

	insinto /usr/share/php/docs/${MY_PN}
	doins examples/*
}
