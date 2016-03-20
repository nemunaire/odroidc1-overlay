# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

EGIT_REPO_URI="git://github.com/mdrjr/c1_aml_libs.git"

DESCRIPTION="ODROID-C1 Amlogic Libraries"
HOMEPAGE="https://github.com/mdrjr/c1_aml_libs.git"
LICENSE="all-rights-reserved"

SLOT="0"

RDEPEND="media-libs/alsa-lib"

src_install() {
	dodir "/usr/include" "/etc/ld.so.conf.d"

	emake DESTDIR="${D}" install

	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/99-amlogic.rules
}
