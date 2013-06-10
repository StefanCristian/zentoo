# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils systemd toolchain-funcs

DESCRIPTION="NTP client and server programs"
HOMEPAGE="http://chrony.tuxfamily.org/"
SRC_URI="http://download.tuxfamily.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="caps ipv6 +readline +rtc"

DEPEND="
	caps? ( sys-libs/libcap )
	readline? ( >=sys-libs/readline-4.1-r4 )
"
RDEPEND="${REPEND}"

DOCS=( examples/chrony.{conf,keys}.example )

src_prepare() {
	sed -i \
		-e 's:/etc/chrony\.:/etc/chrony/chrony.:g' \
		examples/* chrony*.{1,5,8} faq.txt chrony.texi || die
	sed -i \
		-e 's:/var/run:/run:g' \
		conf.c chrony.texi chrony.txt \
		examples/chrony.conf.example || die
}

src_configure() {
	tc-export CC

	# not an autotools generated script
	./configure \
		$( use caps		 || echo --disable-linuxcaps ) \
		$( use ipv6		 || echo --disable-ipv6 ) \
		$( use readline	 || echo --disable-readline ) \
		$( use rtc		 || echo --disable-rtc ) \
		${EXTRA_ECONF} \
		--docdir=/usr/share/doc/${PF} \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--sysconfdir=/etc/chrony \
		--without-nss \
		--without-tomcrypt \
		|| die
}

src_compile() {
	emake all docs
}

src_install() {
	default
	rm "${D}"/usr/share/doc/${PF}/COPYING || die
	doinfo chrony.info*

	newinitd "${FILESDIR}"/chronyd.init chronyd
	newconfd "${FILESDIR}"/chronyd.conf chronyd

	keepdir /var/{lib,log}/chrony /etc/chrony

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/chrony.logrotate chrony

	# systemd stuff
	systemd_dounit "${FILESDIR}"/chronyd.service
	insinto $(systemd_get_utildir)/ntp-units.d/
	doins "${FILESDIR}"/50-chrony.list
}