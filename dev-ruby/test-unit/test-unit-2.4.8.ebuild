# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="TODO README.textile"

# Disable default binwraps
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="An improved version of the Test::Unit framework from Ruby 1.8"
HOMEPAGE="http://test-unit.rubyforge.org/"

LICENSE="Ruby"
SLOT="2"
KEYWORDS="amd64"
IUSE="test"

all_ruby_compile() {
	all_fakegem_compile
}

each_ruby_test() {
	# the rake audit using dev-ruby/zentest currently fails, and we
	# just need to call the testsuite directly.
	# rake audit || die "rake audit failed"
	local rubyflags

	[[ $(basename ${RUBY}) == jruby ]] && rubyflags="-X+O"

	${RUBY} ${rubyflags} test/run-test.rb || die "testsuite failed"
}

all_ruby_install() {
	all_fakegem_install

	# Create a testrb2 wrapper similarly to the rdoc2 wrapper for
	# rdoc-2* series.
	ruby_fakegem_binwrapper testrb /usr/bin/testrb-2
}
