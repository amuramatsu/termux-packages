TERMUX_PKG_HOMEPAGE=https://www.xfce.org/
TERMUX_PKG_DESCRIPTION="Basic utility non-GUI functions for XFCE"
TERMUX_PKG_LICENSE="LGPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
_MAJOR_VERSION=4.17
TERMUX_PKG_VERSION=${_MAJOR_VERSION}.3
TERMUX_PKG_SRCURL=https://archive.xfce.org/src/xfce/libxfce4util/${_MAJOR_VERSION}/libxfce4util-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=27cbe4051f6443a124a967700953cd3580c14645596dc28a82cd4e5fae388fc2
TERMUX_PKG_DEPENDS="glib"
TERMUX_PKG_BUILD_DEPENDS="g-ir-scanner"
TERMUX_PKG_DISABLE_GIR=false
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
--enable-vala=no
--enable-gtk-doc-html=no
"

termux_step_pre_configure() {
	termux_setup_gir
}
