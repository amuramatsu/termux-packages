TERMUX_PKG_HOMEPAGE=http://www.geocities.jp/ep3797/mozc-ut2.html
TERMUX_PKG_DESCRIPTION="Japanese Input method with large dictionary (for emacs)"
TERMUX_PKG_LICENSE="GPL-3.0"
local _MAJOR_VERSION=2.20.2677.102
local _MINOR_VERSION=20171008
TERMUX_PKG_VERSION=$_MAJOR_VERSION.$_MINOR_VERSION
TERMUX_PKG_REVISION=7
TERMUX_PKG_MAINTAINER="MURAMATSU Atsushi @amuramatsu"
TERMUX_PKG_SHA256=3e89b533cd0177156031dbedbc607d953f7ed522cb37b9286490b9f6002d6603
TERMUX_PKG_SRCURL=https://ja.osdn.net/downloads/users/16/16040/mozc-ut2-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_DEPENDS="libprotobuf, libiconv"
TERMUX_PKG_BUILD_DEPENDS="protobuf"
TERMUX_PKG_HOSTBUILD=yes

_MOZC_CONFIG_REPO=https://github.com/hidegit/mozc-config.git
_MOZC_CONFIG_COMMIT=79bd032431320dbb79d3e16d41686e5a58f22218
_MOZCTOROKU_REPO=https://github.com/amuramatsu/mozctoroku.git
_MOZCTOROKU_COMMIT=fb2f064c3a8e36df3f4a9115434d5564c9b551d8

termux_step_host_build() {
	termux_setup_protobuf_host
}

termux_step_post_extract_package() {
	git clone $_MOZC_CONFIG_REPO mozc-config
	(cd mozc-config && git checkout $_MOZC_CONFIG_COMMIT)
	git clone $_MOZCTOROKU_REPO mozctoroku
	(cd mozctoroku && git checkout $_MOZCTOROKU_COMMIT)
	termux_setup_protobuf
}

termux_step_configure () {
	termux_setup_ninja
	cd "$TERMUX_PKG_SRCDIR"
	cd src
	GYP_DEFINES="use_libprotobuf=1 include_dirs=$TERMUX_PREFIX/include library_dirs=$TERMUX_PREFIX/lib" \
	  python2 build_mozc.py gyp \
		--gypdir=$TERMUX_PKG_SRCDIR/src/third_party/gyp \
		--target_platform=Linux --noqt \
		--server_dir=$TERMUX_PREFIX/lib/mozc
}

termux_step_make () {
	cd "$TERMUX_PKG_SRCDIR"
	cd src
	export PATH="${PATH}:$TERMUX_TOPDIR/libprotobuf/host-build/install/bin"
	python2 build_mozc.py build -c Release \
		server/server.gyp:mozc_server \
		unixemacs/emacs.gyp:mozc_emacs_helper
	cd "$TERMUX_PKG_SRCDIR"
	cd mozc-config
	make mozc-config mozc-dict LIBS="-lprotobuf -liconv"
}

termux_step_make_install () {
	local _release_dir=src/out_linux/Release
        local _doc_destdir="${TERMUX_PREFIX}/share/doc/mozc-ut2-emacs"
        local _elisp_destdir="${TERMUX_PREFIX}/share/emacs/site-lisp/mozc-emacs"
	cd "$TERMUX_PKG_SRCDIR"

	# mozc & emacs-mozc
	[ -d "${TERMUX_PREFIX}/lib/mozc"  ] || \
	    mkdir -p "${TERMUX_PREFIX}/lib/mozc"
	install -c -m 755 \
		"${_release_dir}/mozc_server" "${TERMUX_PREFIX}/lib/mozc"
	${STRIP} -g "${TERMUX_PREFIX}/lib/mozc/mozc_server"
	install -c -m 755 \
		"${_release_dir}/mozc_emacs_helper" "${TERMUX_PREFIX}/bin"
	${STRIP} -g "${TERMUX_PREFIX}/bin/mozc_emacs_helper"
	[ -d "$_elisp_destdir" ] || mkdir -p "$_elisp_destdir"
	install -c -m 644 \
		src/unix/emacs/mozc.el "$_elisp_destdir"
	
	# mozc-config
	install -c -m 755 \
		mozc-config/mozc-config "${TERMUX_PREFIX}/bin"
	${STRIP} -g "${TERMUX_PREFIX}/bin/mozc-config"
	install -c -m 755 \
		mozc-config/mozc-dict "${TERMUX_PREFIX}/bin"
	${STRIP} -g "${TERMUX_PREFIX}/bin/mozc-dict"
	[ -d "$_doc_destdir" ] || mkdir -p "$_doc_destdir"
	install -c -m 644 \
		mozc-config/README "$_doc_destdir/README.mozc-config"

	# mozctoroku
	[ -d "$_elisp_destdir" ] || mkdir -p "$_elisp_destdir"
	install -c -m 644 \
		mozctoroku/*.el "$_elisp_destdir"
	[ -d "$_doc_destdir/mozctoroku" ] || mkdir -p "$_doc_destdir/mozctoroku"
	install -c -m 644 \
		mozctoroku/README* "$_doc_destdir/mozctoroku"
	install -c -m 644 \
		mozctoroku/HISTORY* "$_doc_destdir/mozctoroku"
	install -c -m 644 \
		mozctoroku/COPYING "$_doc_destdir/mozctoroku"
}
