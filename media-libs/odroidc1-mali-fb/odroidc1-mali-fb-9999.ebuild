EAPI=6

inherit git-r3

EGIT_REPO_URI="git://github.com/mdrjr/c1_mali_libs.git"

DESCRIPTION="Closed source framebuffer drivers for Mali-400 Odroid-C1"
HOMEPAGE="https://github.com/mdrjr/c1_mali_libs.git"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="!x11-libs/odroidc1-mali
	!x11-libs/mesa"

PATCHES=(
	"${FILESDIR}/0001-Fix-Makefiles.patch"
)

src_compile() {
	touch .gles-only
}

src_install() {
	local opengl_imp="mali"
	local opengl_dir="/usr/$(get_libdir)/opengl/${opengl_imp}"

	dodir /usr/lib
	dodir /usr/include

	insinto /usr/lib
	doins fbdev/mali_libs/libEGL.so
	doins fbdev/mali_libs/libEGL.so.1
	doins fbdev/mali_libs/libEGL.so.1.4
	doins fbdev/mali_libs/libGLESv1_CM.so
	doins fbdev/mali_libs/libGLESv1_CM.so.1
	doins fbdev/mali_libs/libGLESv1_CM.so.1.1
	doins fbdev/mali_libs/libGLESv2.so
	doins fbdev/mali_libs/libGLESv2.so.2
	doins fbdev/mali_libs/libGLESv2.so.2.0
	doins fbdev/mali_libs/libMali.so

	insinto /usr/include/EGL
	doins fbdev/mali_headers/EGL/egl.h
	doins fbdev/mali_headers/EGL/eglext.h
	doins fbdev/mali_headers/EGL/eglplatform.h
	doins fbdev/mali_headers/EGL/fbdev_window.h 

	insinto /usr/include/GLES
	doins fbdev/mali_headers/GLES/gl.h
	doins fbdev/mali_headers/GLES/glext.h
	doins fbdev/mali_headers/GLES/glplatform.h

	insinto /usr/include/GLES2
	doins fbdev/mali_headers/GLES2/gl2.h
	doins fbdev/mali_headers/GLES2/gl2ext.h
	doins fbdev/mali_headers/GLES2/gl2platform.h

	insinto /usr/include/KHR
	doins fbdev/mali_headers/KHR/khrplatform.h



	#emake "libdir=${D}/${opengl_dir}/lib" "includedir=${D}/${opengl_dir}/include" -C x11 install

	# create symlink to libMali and libUMP into /usr/lib
	#dosym "opengl/${opengl_imp}/lib/libMali.so" "/usr/$(get_libdir)/libMali.so"
        #dosym "opengl/${opengl_imp}/lib/libUMP.so" "/usr/$(get_libdir)/libUMP.so"

	# udev rules to get the right ownership/permission for /dev/ump and /dev/mali
	#insinto /lib/udev/rules.d
	#doins "${FILESDIR}"/99-mali-drivers.rules

	#insinto "${opengl_dir}"
	#doins .gles-only
}

