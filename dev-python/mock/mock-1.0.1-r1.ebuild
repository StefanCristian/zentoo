# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="A Python Mocking and Patching Library for Testing"
HOMEPAGE="http://www.voidspace.org.uk/python/mock/ http://pypi.python.org/pypi/mock"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc test"

# dev-python/unittest2 is not required with Python >=3.2.
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		virtual/python-unittest2[${PYTHON_USEDEP}] )"
RDEPEND=""

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( docs/*.txt )

	distutils-r1_python_install_all

	if use doc; then
		dohtml -r html/ -x html/objects.inv -x html/output.txt -x html/_sources
	fi
}
