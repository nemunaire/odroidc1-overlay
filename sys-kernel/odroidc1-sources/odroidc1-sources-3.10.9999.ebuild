# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

ETYPE=sources
K_DEFCONFIG="odroidc_defconfig"
K_SECURITY_UNSUPPORTED=1
EXTRAVERSION="-${PN}/-*"

inherit kernel-2

detect_version
detect_arch

inherit git-r3 versionator

EGIT_REPO_URI="git://github.com/hardkernel/linux.git"
EGIT_BRANCH="odroidc-$(get_version_component_range 1-2).y"
EGIT_CHECKOUT_DIR="$S"

DESCRIPTION="Linux source for Odroid devices"
HOMEPAGE="https://github.com/hardkernel/linux"

KEYWORDS="~arm"

src_unpack()
{
	git-r3_src_unpack
	unpack_set_extraversion
}

src_prepare() {
    epatch "${FILESDIR}"/000_ntp_fix.patch
}
