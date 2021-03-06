# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=TURNSTEP
MODULE_VERSION=2.19.3
inherit perl-module

DESCRIPTION="The Perl DBD::Pg Module"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="virtual/perl-version
	>=dev-perl/DBI-1.52
	dev-db/postgresql-base"
DEPEND="${RDEPEND}"

# testcases require a local database with an
# open password for the postgres user.
SRC_TEST="skip"

src_prepare() {
	postgres_include="$(readlink -f "${EPREFIX}"/usr/include/postgresql)"
	postgres_lib="${postgres_include//include/lib}"
	# Fall-through case is the non-split postgresql
	# The active cases instead get us the matching libdir for the includedir.
	for i in lib lib64 ; do
		if [ -d "${postgres_lib}/${i}" ]; then
			postgres_lib="${postgres_lib}/${i}"
			break
		fi
	done

	# env variables for compilation:
	export POSTGRES_INCLUDE="${postgres_include}"
	export POSTGRES_LIB="${postgres_lib}"
	perl-module_src_prepare
}
