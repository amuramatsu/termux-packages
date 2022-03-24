TERMUX_PKG_HOMEPAGE=https://znc.in/
TERMUX_PKG_DESCRIPTION="An advanced IRC bouncer"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.8.2
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://znc.in/releases/archive/znc-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=ff238aae3f2ae0e44e683c4aee17dc8e4fdd261ca9379d83b48a7d422488de0d
TERMUX_PKG_DEPENDS="libc++, libicu, libsasl, openssl, zlib"
TERMUX_PKG_FORCE_CMAKE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DWANT_I18N=OFF
"
