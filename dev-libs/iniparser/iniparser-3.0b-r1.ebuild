# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib toolchain-funcs

MY_P="${PN}${PV}"

DESCRIPTION="A free stand-alone ini file parsing library."
HOMEPAGE="http://ndevilla.free.fr/iniparser/"
SRC_URI="http://ndevilla.free.fr/iniparser/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-fix-set-functions.patch"
}

src_compile() {
	echo "CFLAGS: ${CFLAGS}"
	sed -i \
		-e "s|\(CFLAGS  =\) -O2|\1 ${CFLAGS}|" \
		-e "s|\(LDFLAGS =\)|\1 ${LDFLAGS}|" \
		-e "s|/usr/lib|/usr/$(get_libdir)|" \
		Makefile || die "sed failed"

	emake CC=$(tc-getCC) AR="$(tc-getAR)" || die "emake failed"
}

src_install() {
	dolib libiniparser.a libiniparser.so.0
	dosym libiniparser.so.0 /usr/$(get_libdir)/libiniparser.so

	insinto /usr/include
	doins src/*.h

	dodoc AUTHORS README
	dohtml html/*
}