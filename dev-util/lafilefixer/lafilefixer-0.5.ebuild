# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Utility to fix your .la files"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
DEPEND=""
RDEPEND=">=app-shells/bash-3.2
	elibc_glibc? ( >=sys-apps/findutils-4.4.0 )"

S=""

src_unpack() { : ; }
src_prepare() { : ; }
src_configure() { : ; }
src_unpack() { : ; }
src_install() {	newbin "${FILESDIR}/${P}" ${PN} ; }

pkg_postinst() {
	elog "This simple utility will fix your .la files to not point to other .la files."
	elog "This is desirable because it will ensure your packages are not broken when"
	elog ".la files are removed from other packages."
	elog ""
	elog "For most uses, lafilefixer --justfixit should 'just work'. This will"
	elog "recurse through the most commonly used library folders and fix all .la"
	elog "files it encounters."
	elog ""
	elog "Read lafilefixer --help for a full description of all options."
}
