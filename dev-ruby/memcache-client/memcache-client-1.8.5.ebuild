# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
USE_RUBY="ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="FAQ.rdoc History.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A ruby library for accessing memcached."
HOMEPAGE="http://github.com/mperham/memcache-client"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/flexmock )"

all_ruby_prepare() {
	# Remove tests that require a running memcache deamon.
	rm test/test_benchmark.rb || die "Unable to remove performance tests."

	# Fix silly JRuby test issue:
	# https://github.com/mperham/memcache-client/issues/issue/14
	sed -i -e '558s/e.message/e.message.downcase/' test/test_mem_cache.rb || die "Could not fix JRuby issue."
}

each_ruby_test() {
	${RUBY} -Ilib -r test/unit test/test_mem_cache.rb || die "Tests failed."
}
