# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="A base library for Airbrake error reporting"
HOMEPAGE="http://github.com/toolmantim/toadhopper"
SRC_URI="https://github.com/toolmantim/${PN}/tarball/v${PV} -> ${P}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RUBY_S="toolmantim-${PN}-*"
