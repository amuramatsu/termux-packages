TERMUX_PKG_HOMEPAGE=https://archlinux.org/pacman/
TERMUX_PKG_DESCRIPTION="a simple library-based package manager"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@Maxython"
TERMUX_PKG_VERSION=6.0.0
TERMUX_PKG_SRCURL=https://sources.archlinux.org/other/pacman/pacman-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=004448085a7747bdc7a0a4dd5d1fb7556c6b890111a06e029ab088f9905d4808
TERMUX_PKG_DEPENDS="bash, libarchive, curl, gpgme"
TERMUX_PKG_BUILD_DEPENDS="doxygen, asciidoc, nettle"
TERMUX_PKG_GROUPS="base-devel"

# A temporary solution to the problem with compiling the documentation.
# https://github.com/termux/termux-packages/pull/7759#issuecomment-945664581
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Ddoc=disabled
"

termux_step_pre_configure() {
	rm -f ./scripts/libmakepkg/executable/sudo.sh.in
	rm -f ./scripts/libmakepkg/executable/fakeroot.sh.in
}

termux_step_post_configure() {
	sed -i 's/$ARGS -o $out $in $LINK_ARGS/$ARGS -o $out $in $LINK_ARGS -landroid-glob/' ${TERMUX_TOPDIR}/pacman/build/build.ninja
}
