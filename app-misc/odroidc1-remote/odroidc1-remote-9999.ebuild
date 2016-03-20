# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

EGIT_REPO_URI="git://github.com/mdrjr/c1_irremote.git"

DESCRIPTION="ODROID-C1 remote control setup"
HOMEPAGE="https://github.com/mdrjr/c1_irremote.git"
LICENSE="freedist"

SLOT="0"
KEYWORDS="~arm"

src_install() {
	insinto /etc
	doins odroid_remote.conf

	insinto /usr/bin
	insopts -m0755
	doins odroid_remote

	insinto /etc/init.d
	doins "${FILESDIR}"/odroid_remote
}
