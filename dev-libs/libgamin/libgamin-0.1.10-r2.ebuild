# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit autotools eutils flag-o-matic libtool python

MY_PN=${PN//lib/}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Library providing the FAM File Alteration Monitor API"
HOMEPAGE="http://www.gnome.org/~veillard/gamin/"
SRC_URI="http://www.gnome.org/~veillard/${MY_PN}/sources/${MY_P}.tar.gz
	mirror://gentoo/${MY_PN}-0.1.9-freebsd.patch.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug kernel_linux python"

RESTRICT="test" # need gam-server

RDEPEND="!app-admin/fam
	!<app-admin/gamin-0.1.10"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
}

src_prepare() {
	# Fix QA warnings, bug #257281, upstream #466791
	epatch "${FILESDIR}/${P}-compilewarnings.patch"

	# Fix compile warnings; bug #188923
	epatch "${DISTDIR}/${MY_PN}-0.1.9-freebsd.patch.bz2"

	# Fix collision problem due to intermediate library, upstream bug #530635
	epatch "${FILESDIR}/${P}-noinst-lib.patch"

	# Build only shared version of Python module.
	epatch "${FILESDIR}/${P}-disable_python_static_library.patch"

	# Python bindings are built/installed manually.
	sed -e "/SUBDIRS += python/d" -i Makefile.am

	# autoconf is required as the user-cflags patch modifies configure.in
	# however, elibtoolize is also required, so when the above patch is
	# removed, replace the following call with a call to elibtoolize
	eautoreconf

	# disable pyc compiling
	mv "${S}"/py-compile "${S}"/py-compile.orig
	ln -s $(type -P true) "${S}"/py-compile
}

src_configure() {
	econf --disable-debug \
		--disable-server \
		$(use_enable kernel_linux inotify) \
		$(use_enable debug debug-api) \
		$(use_with python)
}

src_compile() {
	default

	if use python; then
		python_copy_sources python

		building() {
			emake \
				PYTHON_INCLUDES="$(python_get_includedir)" \
				PYTHON_SITE_PACKAGES="$(python_get_sitedir)" \
				PYTHON_VERSION="$(python_get_version)"
		}
		python_execute_function -s --source-dir python building
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"

	if use python; then
		installation() {
			emake \
				DESTDIR="${D}" \
				PYTHON_SITE_PACKAGES="$(python_get_sitedir)" \
				PYTHON_VERSION="$(python_get_version)" \
				install
		}
		python_execute_function -s --source-dir python installation

		python_clean_installation_image
	fi

	dodoc AUTHORS ChangeLog README TODO NEWS doc/*txt || die "dodoc failed"
	dohtml doc/* || die "dohtml failed"
}

pkg_postinst() {
	if use python; then
		python_mod_optimize gamin.py
	fi
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup gamin.py
	fi
}
