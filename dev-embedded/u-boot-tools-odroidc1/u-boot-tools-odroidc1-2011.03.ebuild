# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs eutils git-r3 versionator

EGIT_REPO_URI=git://github.com/hardkernel/u-boot.git
EGIT_BRANCH="odroidc-v$(get_version_component_range 1-2)"

DESCRIPTION="Odroid C1 U-Boot"
HOMEPAGE="https://github.com/hardkernel/u-boot"
SLOT=0
LICENSE="GPL-2"

KEYWORDS="~arm"

PATCHES=(
	"${FILESDIR}/0001-fix-missing-header.patch"
)

src_compile() {
	# Unset a few KBUILD variables. Bug #540476
	unset KBUILD_OUTPUT KBUILD_SRC
	emake odroidc_config
	emake \
		HOSTSTRIP=: \
		STRIP=: \
		HOSTCC="$(tc-getCC)" \
		HOSTCFLAGS="${CFLAGS} ${CPPFLAGS}"' $(HOSTCPPFLAGS)' \
		HOSTLDFLAGS="${LDFLAGS}" \
		CONFIG_ENV_OVERWRITE=y \
		tools-all
}

src_install() {
	cd build/tools || die
	dobin bmp_logo gen_eth_addr img2srec inca-swap-bytes mkimage ncb ubsha1 uclpack
	dobin easylogo/easylogo
	dobin env/fw_printenv
	dosym fw_printenv /usr/bin/fw_setenv
	doman "${S}"/doc/mkimage.1

	cd ../..
	dodir /opt/hardkernel
	cp -R sd_fuse "${D}/opt/hardkernel" || die "could not copy sd_fuse directory"
}
