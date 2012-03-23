# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_TASK_DOC="doc:rdoc"
RUBY_FAKEGEM_TASK_TEST="spec:normal"

RAKE_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md CHANGELOG"

inherit ruby-fakegem

DESCRIPTION="A replacement for the URI implementation that is part of Ruby's standard library."
HOMEPAGE="http://addressable.rubyforge.org/"

LICENSE="as-is"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:0 )"

all_ruby_prepare() {
	# Remove spec-related tasks so that we don't need to require rspec
	# just to build the documentation, bug 383611.
	sed -i -e '/spectask/d' Rakefile || die
	rm tasks/spec.rake || die
}

each_ruby_test() {
	case ${RUBY} in
		*jruby)
			ewarn "Tests disabled because they crash jruby."
			;;
		*)
			${RUBY} -I lib -S spec spec || die "Tests failed."
			;;
	esac
}
