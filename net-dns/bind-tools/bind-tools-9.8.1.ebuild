# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils autotools flag-o-matic toolchain-funcs

MY_PN=${PN//-tools}
MY_PV=${PV/_p/-P}
MY_PV=${MY_PV/_rc/rc}
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="bind tools: dig, nslookup, host, nsupdate, dnssec-keygen"
HOMEPAGE="http://www.isc.org/software/bind"
SRC_URI="ftp://ftp.isc.org/isc/bind9/${MY_PV}/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc gssapi idn ipv6 pkcs11 ssl urandom xml"

DEPEND="ssl? ( dev-libs/openssl )
	xml? ( dev-libs/libxml2 )
	idn? ( net-dns/idnkit )
	gssapi? ( virtual/krb5 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# bug 231247
	epatch "${FILESDIR}"/${PN}-9.5.0_p1-lwconfig.patch

	# bug #220361
	rm {aclocal,libtool}.m4
	eautoreconf
}

src_configure() {
	local myconf=

	if use urandom; then
		myconf="${myconf} --with-randomdev=/dev/urandom"
	else
		myconf="${myconf} --with-randomdev=/dev/random"
	fi

	# bug 344029
	append-cflags "-DDIG_SIGCHASE"

	# localstatedir for nsupdate -l, bug 395785
	tc-export BUILD_CC
	econf \
		--localstatedir=/var \
		$(use_enable ipv6) \
		$(use_with idn) \
		$(use_with ssl openssl) \
		$(use_with xml libxml2) \
		$(use_with gssapi) \
		$(use_with pkcs11) \
		${myconf}

	# bug #151839
	echo '#undef SO_BSDCOMPAT' >> config.h
}

src_compile() {
	emake -C lib/ || die "emake lib failed"
	emake -C bin/dig/ || die "emake bin/dig failed"
	emake -C bin/nsupdate/ || die "emake bin/nsupdate failed"
	emake -C bin/dnssec/ || die "emake bin/dnssec failed"
}

src_install() {
	dodoc README CHANGES FAQ || die

	cd "${S}"/bin/dig
	dobin dig host nslookup || die
	doman {dig,host,nslookup}.1 || die

	cd "${S}"/bin/nsupdate
	dobin nsupdate || die
	doman nsupdate.1 || die
	if use doc; then
		dohtml nsupdate.html || die
	fi

	cd "${S}"/bin/dnssec
	dobin dnssec-keygen || die
	doman dnssec-keygen.8 || die
	if use doc; then
		dohtml dnssec-keygen.html || die
	fi
}
