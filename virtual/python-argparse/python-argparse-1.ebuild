# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy )
inherit python-r1

DESCRIPTION="A virtual for the Python argparse module"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/argparse[${PYTHON_USEDEP}]' python2_6)"
