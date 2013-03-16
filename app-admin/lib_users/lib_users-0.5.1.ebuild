# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2"

inherit eutils python

DESCRIPTION="goes through /proc and finds all cases of libraries being mapped
but marked as deleted"
HOMEPAGE="http://schwarzvogel.de/software-misc.shtml"
SRC_URI="https://github.com/zentoo/lib_users/tarball/v${PV} -> zentoo-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

DEPEND="test? ( dev-python/nose )"
RDEPEND=""

S="${WORKDIR}/zentoo-${PN}-48b7990"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_test() {
	python_execute_nosetests -P .
}

src_install() {
	newbin lib_users.py lib_users
	dodoc README TODO
}