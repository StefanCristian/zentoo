# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils pam

DESCRIPTION="FTP layout package"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="pam"

DEPEND="pam? ( virtual/pam )
	!<net-ftp/proftpd-1.2.10-r6
	!<net-ftp/pure-ftpd-1.0.20-r2
	!<net-ftp/vsftpd-2.0.3-r1"
RDEPEND="${DEPEND}"

S=${WORKDIR}

pkg_setup() {
	# Check if home exists
	local exists=false
	[[ -d "${ROOT}home/ftp" ]] && exists=true

	# Add our default ftp user
	enewgroup ftp 21
	enewuser ftp 21 -1 /home/ftp ftp

	# If home did not exist and does now then we created it in the enewuser
	# command. Now we have to change it's permissions to something sane.
	if [[ ${exists} == "false" && -d "${ROOT}home/ftp" ]] ; then
		chown root:ftp "${ROOT}"home/ftp
	fi
}

src_install() {
	# The ftpusers file is a list of people who are NOT allowed
	# to use the ftp service.
	insinto /etc
	doins "${FILESDIR}/ftpusers" || die

	# Ideally we would create the home directory here with a dodir.
	# But we cannot until bug #9849 is solved - so we kludge in pkg_postinst()

	newpamd "${FILESDIR}/ftp-pamd-include" ftp
}
