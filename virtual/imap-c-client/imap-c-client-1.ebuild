# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Virtual for IMAP c-client"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="ssl"

DEPEND=""
RDEPEND=" || (	net-libs/c-client[ssl=]
				net-mail/uw-imap[ssl=] )"
