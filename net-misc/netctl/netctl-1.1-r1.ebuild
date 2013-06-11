# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bash-completion-r1 eutils

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://projects.archlinux.org/netctl.git"
	inherit git-2
	DEPEND="app-text/asciidoc"
else
	SRC_URI="ftp://ftp.archlinux.org/other/packages/${PN}/${P}.tar.xz"
	KEYWORDS="amd64"
fi

DESCRIPTION="Profile based network connection tool from Arch Linux"
HOMEPAGE="https://www.archlinux.org/netctl/"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND+="
	virtual/pkgconfig
	sys-apps/systemd
"
RDEPEND="
	>=app-shells/bash-4.0
	>=net-dns/openresolv-3.5.4-r1
	sys-apps/iproute2
	sys-apps/systemd
	!<net-misc/dhcpcd-5.6.7
"

src_prepare() {
	epatch "${FILESDIR}"/netctl-zentoo.patch
	sed -i -e "s:/usr/bin/ifplugd:/usr/sbin/ifplugd:" \
		"services/netctl-ifplugd@.service" || die
}

src_compile() {
	return 0
}

src_install() {
	emake DESTDIR="${D%/}" SHELL=bash install
	dodoc AUTHORS NEWS README
	newbashcomp contrib/bash-completion netctl
	insinto /usr/share/zsh/site-functions
	newins contrib/zsh-completion _netctl
}