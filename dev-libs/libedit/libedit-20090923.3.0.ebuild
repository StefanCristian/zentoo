# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs versionator

MY_PV=$(get_major_version)-$(get_after_major_version)
MY_P=${PN}-${MY_PV}

DESCRIPTION="BSD replacement for libreadline."
HOMEPAGE="http://www.thrysoee.dk/editline/"
SRC_URI="http://www.thrysoee.dk/editline/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-libs/ncurses
	!<=sys-freebsd/freebsd-lib-6.2_rc1"

RDEPEND=${DEPEND}

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}"

	epatch "${FILESDIR}"/${PN}-20090111-3.0-weak_reference.patch
}

src_install() {
	emake DESTDIR="${D}" install

	gen_usr_ldscript -a edit
}
