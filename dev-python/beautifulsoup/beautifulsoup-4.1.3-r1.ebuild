# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )

inherit distutils-r1

MY_PN="${PN}4"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Provides pythonic idioms for iterating, searching, and modifying an HTML/XML parse tree"
HOMEPAGE="http://www.crummy.com/software/BeautifulSoup/
	http://pypi.python.org/pypi/beautifulsoup4"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="4"
KEYWORDS="amd64"
IUSE="doc test"

DEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
		test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}] )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

python_compile_all() {
	if use doc; then
		emake -C doc html
	fi
}

python_test() {
	nosetests -w "${BUILD_DIR}"/lib || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=doc/build/html/.
	distutils-r1_python_install_all
}