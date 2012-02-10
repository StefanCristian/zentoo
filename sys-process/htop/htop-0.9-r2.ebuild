# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit autotools eutils flag-o-matic multilib

DESCRIPTION="interactive process viewer"
HOMEPAGE="http://htop.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug elibc_FreeBSD kernel_linux openvz unicode vserver"

RDEPEND="sys-libs/ncurses[unicode?]"
DEPEND="${RDEPEND}"

DOCS=( ChangeLog README TODO )

pkg_setup() {
	if use elibc_FreeBSD && ! [[ -f ${ROOT}/proc/stat && -f ${ROOT}/proc/meminfo ]]; then
		eerror
		eerror "htop needs /proc mounted to compile and work, to mount it type"
		eerror "mount -t linprocfs none /proc"
		eerror "or uncomment the example in /etc/fstab"
		eerror
		die "htop needs /proc mounted"
	fi

	if ! has_version sys-process/lsof; then
		ewarn "To use lsof features in htop(what processes are accessing"
		ewarn "what files), you must have sys-process/lsof installed."
	fi
}

src_prepare() {
	sed -i -e '1c\#!'"${EPREFIX}"'/usr/bin/python' \
		scripts/MakeHeader.py || die

	epatch "${FILESDIR}"/${P}-debug.patch #352024, 372911
	epatch "${FILESDIR}"/${P}-uclibc.patch #374595

	# patch accepted by upstream (bug 3383385), remove on >=0.9.1
	epatch "${FILESDIR}"/${P}-small-width.patch

	eautoreconf
}

src_configure() {
	use debug && append-flags -DDEBUG

	econf \
		$(use_enable openvz) \
		$(use_enable kernel_linux cgroup) \
		$(use_enable vserver) \
		$(use_enable unicode) \
		--enable-taskstats \
		--without-valgrind
}
