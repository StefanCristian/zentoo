# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# ebuild generated by hackport 0.2.9

EAPI="3"

CABAL_FEATURES="bin"
inherit autotools eutils haskell-cabal

DESCRIPTION="Alex is a tool for generating lexical analysers in Haskell"
HOMEPAGE="http://www.haskell.org/alex/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

RDEPEND=""
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2
		>=dev-lang/ghc-6.8.2
	doc? (	~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets
		>=dev-libs/libxslt-1.1.2 )"

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.3.5-missing-test.patch"
	epatch "${FILESDIR}/${PN}-2.3.5-ghc-7.2.patch"

	for f in Scan Parser; do
		rm "${S}/src/$f."*
		mv "${S}/dist/build/alex/alex-tmp/$f.hs" "${S}"/src/
	done

	if use doc; then
		cd "${S}/doc/"
		eautoreconf || die "eautoreconf for docs failed"
	fi
}

src_configure() {
	cabal_src_configure

	if use doc; then
		cd "${S}/doc/"
		econf || die "econf for docs failed"
	fi
}

src_compile() {
	cabal_src_compile

	if use doc; then
		emake -C "${S}/doc/" -j1 || die "emake for docs failed"
	fi
}

src_test() {
	emake -C "${S}/tests/" || die "emake for tests failed"
}

src_install() {
	cabal_src_install

	if use doc; then
		doman "${S}/doc/alex.1"
		dohtml -r "${S}/doc/alex/"
	fi
	dodoc README
}
