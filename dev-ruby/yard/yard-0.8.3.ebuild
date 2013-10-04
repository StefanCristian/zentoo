# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_TASK_DOC="yard"

RUBY_FAKEGEM_EXTRADOC="README.md ChangeLog"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRAINSTALL="templates"

inherit ruby-fakegem

DESCRIPTION="Documentation generation tool for the Ruby programming language"
HOMEPAGE="http://yardoc.org/"

# The gem lakes the gemspec file needed to pass tests.
SRC_URI="https://github.com/lsegal/yard/tarball/${PV} -> ${P}-git.tgz"
RUBY_S="lsegal-yard-*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

#RUBY_PATCHES=( ${P}-test-failures.patch )

ruby_add_bdepend "doc? ( || ( dev-ruby/bluecloth dev-ruby/maruku dev-ruby/rdiscount dev-ruby/kramdown ) )"

ruby_add_bdepend "test? ( dev-ruby/ruby-gettext )"

all_ruby_prepare() {
	sed -i -e '/[Bb]undler/ s:^:#:' spec/spec_helper.rb || die
	sed -i -e "s/require 'bundler'; rescue LoadError//" spec/cli/server_spec.rb || die
}

each_ruby_prepare() {
	case ${RUBY} in
		*jruby)
			# This spec requires rdiscount which is a C extension.
			sed -i -e '150s/should/should_not/' spec/templates/helpers/html_helper_spec.rb || die
			sed -i -e '/should return file contents if found/,/end/ s:^:#:' spec/server/commands/static_file_command_spec.rb || die
			;;
		*)
			;;
	esac
}