EAPI=5

inherit git-r3

EGIT_REPO_URI="git://github.com/mdrjr/c1_aml_libs.git"

DESCRIPTION="ODROID-C1 Amlogic Libraries"
HOMEPAGE="https://github.com/mdrjr/c1_aml_libs.git"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	media-libs/alsa-lib"


src_install() {
	dodir "/usr/include" "/etc/ld.so.conf.d"

	emake DESTDIR="${D}" install

	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/99-amlogic.rules
}
