EAPI=5

inherit git-r3

EGIT_REPO_URI="git://github.com/mdrjr/c1_irremote.git"

DESCRIPTION="ODROID-C1 remote control setup"
HOMEPAGE="https://github.com/mdrjr/c1_irremote.git"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
        insinto /etc
        doins odroid_remote.conf

	insinto /usr/bin
	insopts -m0755
	doins odroid_remote

	insinto /etc/init.d
        doins "${FILESDIR}"/odroid_remote
}
