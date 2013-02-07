# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit java-virtuals-2

DESCRIPTION="Virtual for servlet api"
HOMEPAGE="http://java.sun.com/products/servlet/"
SRC_URI=""

LICENSE="public-domain"
SLOT="${PV}"
KEYWORDS="amd64"
IUSE=""

RDEPEND="|| (
		dev-java/tomcat-servlet-api:${SLOT}
		dev-java/resin-servlet-api:${SLOT}
		dev-java/glassfish-servlet-api:${SLOT}
	)"

JAVA_VIRTUAL_PROVIDES="tomcat-servlet-api-${SLOT} resin-servlet-api-${SLOT} glassfish-servlet-api-${SLOT}"
