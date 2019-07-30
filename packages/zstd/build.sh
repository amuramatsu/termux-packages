TERMUX_PKG_HOMEPAGE=https://github.com/facebook/zstd
TERMUX_PKG_DESCRIPTION="Zstandard compression."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.4.2
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/facebook/zstd/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=7a6e1dad34054b35e2e847eb3289be8820a5d378228802239852f913c6dcf6a7
TERMUX_PKG_DEPENDS="liblzma, zlib"
TERMUX_PKG_BREAKS="zstd-dev"
TERMUX_PKG_REPLACES="zstd-dev"
TERMUX_PKG_BUILD_IN_SRC=yes
