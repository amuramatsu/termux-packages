TERMUX_PKG_HOMEPAGE=https://www.graphviz.org/
TERMUX_PKG_DESCRIPTION="Rich set of graph drawing tools"
TERMUX_PKG_LICENSE="EPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=5.0.0
#TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://gitlab.com/graphviz/graphviz/-/archive/$TERMUX_PKG_VERSION/graphviz-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=f8cc576694ae93659f453b6b4a4c2f04572a90cfccdca2d4271f2e7c60bb3d60
TERMUX_PKG_DEPENDS="libandroid-glob, libc++, libcairo, pango, libexpat, libltdl, librsvg, libgd, zlib"
TERMUX_PKG_BREAKS="graphviz-dev"
TERMUX_PKG_REPLACES="graphviz-dev"
TERMUX_PKG_BUILD_DEPENDS="libtool"
TERMUX_PKG_FORCE_CMAKE=true
TERMUX_PKG_RM_AFTER_INSTALL="bin/*-config share/man/man1/*-config.1"

termux_step_post_make_install() {
	# Some binaries (dot_builtins, gvpack) links against these:
	cd $TERMUX_PREFIX/lib
	for lib in graphviz/*.so*; do
		ln -s -f $lib $(basename $lib)
	done
}

termux_step_create_debscripts() {
	echo "#!$TERMUX_PREFIX/bin/sh" > postinst
	echo "dot -c" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
