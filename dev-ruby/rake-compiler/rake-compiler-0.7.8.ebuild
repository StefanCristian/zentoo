# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
USE_RUBY="ruby18 ree18 jruby"

# Tests for now seem only to work when rubygems is fully installed for
# the implementation and that for now only means Ruby 1.8
RUBY_FAKEGEM_TASK_TEST="-f tasks/rspec.rake -f tasks/cucumber.rake spec cucumber"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="Provide a standard and simplified way to build and package Ruby extensions"
HOMEPAGE="http://github.com/luislavena/rake-compiler"
LICENSE="as-is" # truly

SRC_URI="http://github.com/luislavena/${PN}/tarball/v${PV} -> ${P}.tar.gz"
S="${WORKDIR}/luislavena-${PN}-*"

KEYWORDS="amd64"
SLOT="0"
IUSE=""

USE_RUBY=ruby18 \
	ruby_add_bdepend "test? ( dev-util/cucumber )"

ruby_add_bdepend "test? ( dev-ruby/rspec:0 dev-ruby/rubygems )"
ruby_add_rdepend "dev-ruby/rake"

each_ruby_prepare() {
	case ${RUBY} in
		*jruby)
			# Remove this task so that it won't load on Ruby 1.9 and JRuby
			# that lack the package_task file. It is, though, needed for the
			# tests
			rm tasks/gem.rake || die
			# Remove specs aimed at a C-compiling ruby implementation.
			rm spec/lib/rake/extensiontask_spec.rb || die
			;;
		*)
			;;
	esac
}

each_ruby_test() {
	case ${RUBY} in
		*jruby)
			${RUBY} -S spec spec || die "Tests failed."
			;;
		*)
			each_fakegem_test
			;;
	esac
}
