# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpy/rpy-2.3.9.ebuild,v 1.1 2014/02/12 00:53:18 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3} )

inherit distutils-r1

MYSLOT=2
MY_PN=${PN}${MYSLOT}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python interface to the R Programming Language"
HOMEPAGE="http://rpy.sourceforge.net/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="AGPL-3 GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND="
	>=dev-lang/R-3
	dev-python/numpy[${PYTHON_USEDEP}]
	!<=dev-python/rpy-1.0.2-r2"
DEPEND="${RDEPEND}
	test? ( >=dev-python/pandas-0.13[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_test() {
	cd "${BUILD_DIR}"/lib || die
	${PYTHON} -m 'rpy2.tests' -v || die
}
