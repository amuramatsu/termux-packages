TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/chess/
TERMUX_PKG_DESCRIPTION="Chess-playing program"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=6.2.8
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/chess/gnuchess-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=d50446cda8012240321da39cddbb4df4d08458a8d538a4738882814139583847
TERMUX_PKG_DEPENDS="libc++, ncurses, readline"
TERMUX_PKG_RM_AFTER_INSTALL="bin/gnuchessu bin/gnuchessx"
