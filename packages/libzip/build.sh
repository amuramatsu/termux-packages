TERMUX_PKG_HOMEPAGE=https://libzip.org/
TERMUX_PKG_DESCRIPTION="Library for reading, creating, and modifying zip archives"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_VERSION=1.7.0
TERMUX_PKG_REVISION=4
TERMUX_PKG_SRCURL=https://libzip.org/download/libzip-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=cfe303cc224bf23c5256a458de5e21a3d466dd352201f2fe44e99297aeae8b21
TERMUX_PKG_DEPENDS="libbz2, openssl, zlib"
TERMUX_PKG_BREAKS="libzip-dev"
TERMUX_PKG_REPLACES="libzip-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_GNUTLS=NO
-DENABLE_MBEDTLS=NO
-DENABLE_OPENSSL=YES
"
