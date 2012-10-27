# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

JAVA_PKG_OPT_USE="hadoop"

inherit autotools eutils multilib java-pkg-opt-2 flag-o-matic

DESCRIPTION="Ceph distributed filesystem"
HOMEPAGE="http://ceph.com/"
SRC_URI="http://ceph.com/download/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug fuse gtk hadoop libatomic radosgw static-libs tcmalloc"

CDEPEND="
	dev-libs/boost
	dev-libs/fcgi
	dev-libs/libaio
	dev-libs/libedit
	dev-libs/crypto++
	sys-apps/keyutils
	fuse? ( sys-fs/fuse )
	libatomic? ( dev-libs/libatomic_ops )
	gtk? (
		x11-libs/gtk+:2
		dev-cpp/gtkmm:2.4
		gnome-base/librsvg
	)
	radosgw? (
		dev-libs/fcgi
		dev-libs/expat
		net-misc/curl
	)
	tcmalloc? ( dev-util/google-perftools )
	hadoop? ( >=virtual/jdk-1.5 )
	"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	sys-fs/btrfs-progs"

STRIP_MASK="/usr/lib*/rados-classes/*"

src_prepare() {
	sed -e 's:invoke-rc\.d.*:/etc/init.d/ceph reload >/dev/null:' \
		-i src/logrotate.conf || die
	sed -i "/^docdir =/d" src/Makefile.am || die #fix doc path
	# disable testsnaps
	sed -e '/testsnaps/d' -i src/Makefile.am || die
	sed -e "/bin=/ s:lib:$(get_libdir):" "${FILESDIR}"/${PN}.initd \
		> "${T}"/${PN}.initd || die
	sed -i -e '/AM_INIT_AUTOMAKE/s:-Werror ::' src/leveldb/configure.ac || die #423755
	eautoreconf
}

src_configure() {
	use hadoop && append-cppflags $(java-pkg_get-jni-cflags)

	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--includedir=/usr/include \
		$(use_with debug) \
		$(use_with fuse) \
		$(use_with libatomic libatomic-ops) \
		$(use_with radosgw) \
		$(use_with gtk gtk2) \
		$(use_enable static-libs static) \
		$(use_with tcmalloc) \
		$(use_with hadoop)
}

src_install() {
	default

	prune_libtool_files --all

	rmdir "${ED}/usr/sbin"

	exeinto /usr/$(get_libdir)/ceph
	newexe src/init-ceph ceph_init.sh

	insinto /etc/logrotate.d/
	newins src/logrotate.conf ${PN}

	chmod 644 "${ED}"/usr/share/doc/${PF}/sample.*

	keepdir /var/lib/${PN}
	keepdir /var/lib/${PN}/tmp
	keepdir /var/log/${PN}/stat

	newinitd "${T}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
}