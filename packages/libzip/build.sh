TERMUX_PKG_HOMEPAGE=https://libzip.org/
TERMUX_PKG_DESCRIPTION="Library for reading, creating, and modifying zip archives"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com>"
TERMUX_PKG_VERSION=1.6.0
TERMUX_PKG_SRCURL=https://libzip.org/download/libzip-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=70c4bb351dec256fb727053a161faa14c6fe244988b12943800aafc5ccbf5aff
TERMUX_PKG_DEPENDS="libbz2, openssl, zlib"
TERMUX_PKG_BREAKS="libzip-dev"
TERMUX_PKG_REPLACES="libzip-dev"
