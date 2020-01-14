TERMUX_PKG_HOMEPAGE=http://isl.gforge.inria.fr/
TERMUX_PKG_DESCRIPTION="Library for manipulating sets and relations of integer points bounded by linear constraints"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_VERSION=0.22
TERMUX_PKG_SRCURL=http://isl.gforge.inria.fr/isl-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=6c8bc56c477affecba9c59e2c9f026967ac8bad01b51bdd07916db40a517b9fa
TERMUX_PKG_DEPENDS="libgmp"
TERMUX_PKG_BREAKS="libisl-dev"
TERMUX_PKG_REPLACES="libisl-dev"
