EAPI=5

inherit autotools-utils xorg-2 git-r3

EGIT_REPO_URI="https://github.com/mdrjr/c1_mali_ddx.git"
SRC_URI=""

DESCRIPTION="X.org Mali video driver for ODROID-C1"
HOMEPAGE="http://www.hardkernel.com/"

KEYWORDS=""
SLOT=0
IUSE="gles1 gles2"

RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	gles1? ( x11-libs/odroidc1-mali )
	gles2? ( x11-libs/odroidc1-mali )
	x11-proto/fontsproto
	x11-proto/xproto
	x11-libs/libdrm"

PATCHES=( "${FILESDIR}/0001-Fix-DESTDIR-when-performing-install.patch" )

src_compile() {
	autotools-utils_src_compile
	cp "./src/xorg.conf" "${BUILD_DIR}/src/xorg.conf"
}
