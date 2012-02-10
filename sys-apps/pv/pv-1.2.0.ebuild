# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="Pipe Viewer: a tool for monitoring the progress of data through a pipe"
HOMEPAGE="http://www.ivarch.com/programs/pv.shtml"
SRC_URI="http://pipeviewer.googlecode.com/files/${P}.tar.bz2"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls"

DOCS=( README doc/NEWS doc/TODO )

src_configure() {
	econf $(use_enable nls)
}

src_compile() {
	emake LD="$(tc-getLD)"
}
