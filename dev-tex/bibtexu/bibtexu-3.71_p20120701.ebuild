# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="8-bit Implementation of BibTeX 0.99 with a Very Large Capacity"
HOMEPAGE="http://tug.org/texlive/"
SRC_URI="mirror://gentoo/texlive-${PV#*_p}-source.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=">=dev-libs/kpathsea-6.1.0_p20120701
		>=dev-libs/icu-4.4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/texlive-${PV#*_p}-source/texk/${PN}

src_configure() {
	econf \
		--with-system-kpathsea \
		--with-system-icu
}

src_install() {
	emake \
		DESTDIR="${D}" \
		csfdir="${EPREFIX}/usr/share/texmf-dist/bibtexu/csf/base" \
		btdocdir="${EPREFIX}/usr/share/doc/${PF}" \
		install || die
	dodoc 00readme.txt ChangeLog csfile.txt HISTORY
}
