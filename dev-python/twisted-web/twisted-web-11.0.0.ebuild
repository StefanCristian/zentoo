# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython *-pypy-*"
MY_PACKAGE="Web"

inherit twisted versionator

DESCRIPTION="Twisted web server, programmable in Python"

KEYWORDS="amd64"
IUSE="soap"

DEPEND="=dev-python/twisted-core-$(get_version_component_range 1-2)*
	soap? ( dev-python/soappy )"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="twisted/plugins twisted/web"

src_prepare() {
	distutils_src_prepare

	if [[ "${EUID}" -eq 0 ]]; then
		# Disable tests failing with root permissions.
		sed -e "s/test_forbiddenResource/_&/" -i twisted/web/test/test_static.py
		sed -e "s/testDownloadPageError3/_&/" -i twisted/web/test/test_webclient.py
	fi
}
