TERMUX_PKG_HOMEPAGE=https://fmt.dev/latest/index.html
TERMUX_PKG_DESCRIPTION="Open-source formatting library for C++"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_LICENSE_FILE="LICENSE.rst"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=8.1.1
TERMUX_PKG_SRCURL=https://github.com/fmtlib/fmt/archive/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=3d794d3cf67633b34b2771eb9f073bde87e846e0d395d254df7b211ef1ec7346
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DFMT_TEST=OFF"
TERMUX_PKG_NO_STATICSPLIT=true
