# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
# Test suite requires optional extension modules not available with Jython.
PYTHON_TESTS_RESTRICTED_ABIS="*-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Interfaces for Python"
HOMEPAGE="http://pypi.python.org/pypi/zope.interface"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# net-zope/zope-fixers is required for building with Python 3.
DEPEND="dev-python/setuptools
	net-zope/zope-fixers"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="CHANGES.txt src/zope/interface/*.txt"
PYTHON_MODNAME="${PN/-//}"

src_install() {
	distutils_src_install
	python_clean_installation_image
}
