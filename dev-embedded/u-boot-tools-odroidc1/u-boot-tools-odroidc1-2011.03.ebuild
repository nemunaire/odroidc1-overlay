# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils toolchain-funcs git-2 versionator

MY_P="u-boot-${PV/_/-}"
EGIT_REPO_URI=https://github.com/hardkernel/u-boot
EGIT_PROJECT="u-boot.git"
EGIT_BRANCH="odroidc-v2011.03"

DESCRIPTION="Odroid C1 U-Boot"
HOMEPAGE="https://github.com/hardkernel/u-boot"
SLOT=0
LICENSE="GPL-2"
KEYWORDS="amd64 arm x86"
IUSE=""

S=${WORKDIR}/${MY_P}
src_unpack() {
    git-2_src_unpack
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
}

src_install() {
    cd tools
    dobin bmp_logo gen_eth_addr img2srec mkimage
    dobin easylogo/easylogo
    dobin env/fw_printenv
    dosym fw_printenv /usr/bin/fw_setenv
    insinto /etc
    doins env/fw_env.config
    cd ..
    insinto /opt/hardkernel
    dodir sd_fuse
}
