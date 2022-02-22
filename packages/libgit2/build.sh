TERMUX_PKG_HOMEPAGE=https://libgit2.github.com/
TERMUX_PKG_DESCRIPTION="C library implementing Git core methods"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.4.1
TERMUX_PKG_SRCURL=https://github.com/libgit2/libgit2/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=fccd371a271133e29d002dd207490d22a0c9b06992b874b8edb8366532a94f54
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libssh2, openssl, pcre, zlib"
TERMUX_PKG_BUILD_DEPENDS="libiconv, libpcreposix"
TERMUX_PKG_BREAKS="libgit2-dev"
TERMUX_PKG_REPLACES="libgit2-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTS=OFF
-DUSE_SSH=ON
-DREGEX_BACKEND=pcre
"

termux_step_pre_configure() {
	find "$TERMUX_PKG_SRCDIR" -name CMakeLists.txt | xargs -n 1 \
		sed -i 's/\( PROPERTIES C_STANDARD\) 90/\1 99/g'
}
