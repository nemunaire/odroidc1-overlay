# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

ETYPE=sources

inherit eutils git-r3 versionator

EGIT_REPO_URI=git://github.com/hardkernel/u-boot.git
EGIT_BRANCH="odroidc-v$(get_version_component_range 1-2)"
EGIT_CHECKOUT_DIR="$S"

DESCRIPTION="Odroid C1 U-Boot"
HOMEPAGE="https://github.com/hardkernel/u-boot"
SLOT=0
LICENSE="GPL-2"

KEYWORDS="~arm"

src_unpack() {
    git-r3_src_unpack
}

src_prepare() {
    epatch "${FILESDIR}"/000_change_abi.patch
}

src_compile() {
    export ARCH=arm
    emake \
        HOSTSTRIP=: \
        HOSTCC="$(tc-getCC)" \
        HOSTCFLAGS="${CFLAGS} ${CPPFLAGS}"' $(HOSTCPPFLAGS)' \
        odroidc_config
    emake
    emake tools-all
}

src_install() {
    cd build/tools
    dobin bmp_logo easylogo/easylogo env/fw_printenv gen_eth_addr img2srec inca-swap-bytes mkimage ncb ubsha1 uclpack
    cd ../..
    insinto /opt/hardkernel
    dodir sd_fuse
}
