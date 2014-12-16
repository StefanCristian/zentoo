# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KV_FULL="${PV}-gentoo"

inherit linux-image

DESCRIPTION="Argent Kernel Image"
HOMEPAGE="http://www.argentlinux.ro"

BASE_URI="http://mirror.zenops.net/argent"
SRC_URI="amd64? ( ${BASE_URI}/amd64/linux/linux-${PV}-gentoo-${PR}.tar.xz )"

LICENSE="GPL-2"
KEYWORDS="amd64"
