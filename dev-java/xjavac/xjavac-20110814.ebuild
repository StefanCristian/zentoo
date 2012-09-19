# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit java-pkg-2 java-ant-2

DESCRIPTION="The implementation of the javac compiler for IBM JDK 1.4 (needed for xerces-2)"
SRC_URI="mirror://gentoo/${P}.tar.gz"
#Note that the tarball has xjavac-ibm-1_5.patch already applied (not in upstream)
IUSE=""
HOMEPAGE="http://cvs.apache.org/viewcvs.cgi/xml-xerces/java/tools/src/XJavac.java"
LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="amd64"
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.7"

java_prepare() {
	cp "${FILESDIR}/${PN}-20041208-build.xml" ./build.xml || die "failed to cp build.xml"
}

src_compile() {
	eant jar -Dclasspath=$(java-pkg_getjars ant-core)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
}