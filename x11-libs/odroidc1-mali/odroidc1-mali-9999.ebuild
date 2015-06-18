EAPI=5

inherit git-r3

EGIT_REPO_URI="git://github.com/mdrjr/c1_mali_libs.git"

DESCRIPTION="Closed source drivers for Mali-400 Odroid-C1"
HOMEPAGE="https://github.com/mdrjr/c1_mali_libs.git"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=app-eselect/eselect-opengl-1.2.6"
RDEPEND="${DEPEND}
	media-libs/mesa[gles1,gles2]"

src_prepare() {
	epatch "${FILESDIR}/0001-Fix-Makefiles.patch"
}

src_compile() {
	touch .gles-only
}

src_install() {
	local opengl_imp="mali"
	local opengl_dir="/usr/$(get_libdir)/opengl/${opengl_imp}"

	dodir "${opengl_dir}/lib" "${opengl_dir}/include" "${opengl_dir}/extensions"

	emake "libdir=${D}/${opengl_dir}/lib" "includedir=${D}/${opengl_dir}/include" -C x11 install

	# udev rules to get the right ownership/permission for /dev/ump and /dev/mali
	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/99-mali-drivers.rules

	insinto "${opengl_dir}"
	doins .gles-only
}

pkg_postinst() {
	elog "You must be in the video group to use the Mali 3D acceleration."
	elog
	elog "To use the Mali OpenGL ES libraries, run \"eselect opengl set mali\""
}

pkg_prerm() {
	"${ROOT}"/usr/bin/eselect opengl set --use-old --ignore-missing xorg-x11
}

pkg_postrm() {
	"${ROOT}"/usr/bin/eselect opengl set --use-old --ignore-missing xorg-x11
}
