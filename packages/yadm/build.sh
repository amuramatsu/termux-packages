TERMUX_PKG_HOMEPAGE=https://github.com/TheLocehiliosan/yadm
TERMUX_PKG_DESCRIPTION="Yet Another Dotfiles Manager"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com>"
TERMUX_PKG_VERSION=2.3.0
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/TheLocehiliosan/yadm/archive/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=421c357a240b5ac4e6b971bb2d33414e9551a337993116bf0ea4f411952aab87
TERMUX_PKG_DEPENDS="git"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	# Do not try to run 'make' as this causes
	# build failure.
	return
}

termux_step_make_install() {
	install -Dm700 "$TERMUX_PKG_SRCDIR"/yadm "$TERMUX_PREFIX"/bin/
	install -Dm600 "$TERMUX_PKG_SRCDIR"/yadm.1 "$TERMUX_PREFIX"/share/man/man1/
}
