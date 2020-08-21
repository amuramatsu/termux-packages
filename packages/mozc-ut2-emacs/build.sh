TERMUX_PKG_HOMEPAGE=http://linuxplayers.g1.xrea.com/mozc-ut.html
TERMUX_PKG_DESCRIPTION="Japanese Input method with large dictionary (for emacs)"
TERMUX_PKG_LICENSE="GPL-3.0"
_MAJOR_VERSION=2.23.2815.102+dfsg
_MINOR_VERSION=20200821.1
TERMUX_PKG_VERSION=$_MAJOR_VERSION.$_MINOR_VERSION
TERMUX_PKG_MAINTAINER="MURAMATSU Atsushi @amuramatsu"
TERMUX_PKG_SHA256=258120e3e1af2268ec46455cdf50ff2c918af6e3928c5efc13e55eedbf0ce196
TERMUX_PKG_SRCURL=ftp://ftp.jp.debian.org/debian/pool/main/m/mozc/mozc_${_MAJOR_VERSION}.orig.tar.xz
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_DEPENDS="libprotobuf, libiconv"
TERMUX_PKG_BUILD_DEPENDS="protobuf"
TERMUX_PKG_HOSTBUILD=yes

_UTDIC_SRCURL=https://osdn.net/downloads/users/26/26575/mozcdic-ut-$_MINOR_VERSION.tar.bz2
_UTDIC_SHA256=f311ad53e233db87e2ab591a31c6b3901e6d2c736a2bd262a11c5bb1d0b58b76

_GYP_REPO=https://chromium.googlesource.com/external/gyp.git
_GYP_COMMIT=4ec6c4e3a94bd04a6da2858163d40b2429b8aad1
_JP_USAGE_DICT_REPO=https://github.com/hiroyuki-komatsu/japanese-usage-dictionary
_JP_USAGE_DICT_COMMIT=e5b3425575734c323e1d947009dd74709437b684

_MOZC_CONFIG_REPO=https://github.com/hidegit/mozc-config.git
_MOZC_CONFIG_COMMIT=79bd032431320dbb79d3e16d41686e5a58f22218
_MOZCTOROKU_REPO=https://github.com/amuramatsu/mozctoroku.git
_MOZCTOROKU_COMMIT=fb2f064c3a8e36df3f4a9115434d5564c9b551d8

termux_step_host_build() {
	termux_setup_protobuf_host
}

termux_step_post_get_source() {
	mkdir src/third_party
    	git clone $_GYP_REPO src/third_party/gyp
	(cd src/third_party/gyp && git checkout $_GYP_COMMIT)
	git clone $_JP_USAGE_DICT_REPO src/third_party/japanese_usage_dictionary
	(cd src/third_party/japanese_usage_dictionary && git checkout $_JP_USAGE_DICT_COMMIT)
	termux_download \
		$_UTDIC_SRCURL \
		mozcdic-ut-${_MINOR_VERSION}.tar.bz2 \
		$_UTDIC_SHA256
	tar jvxf mozcdic-ut-${_MINOR_VERSION}.tar.bz2
	cat mozcdic-ut-${_MINOR_VERSION}/mozcdic-*-${_MINOR_VERSION}.txt \
	    >> src/data/dictionary_oss/dictionary00.txt
	git clone $_MOZC_CONFIG_REPO mozc-config
	(cd mozc-config && git checkout $_MOZC_CONFIG_COMMIT)
	git clone $_MOZCTOROKU_REPO mozctoroku
	(cd mozctoroku && git checkout $_MOZCTOROKU_COMMIT)
	termux_setup_protobuf
	find src -name '*.gyp' -exec sed -i.bak "s/'python'/'python2'/g" {} \;
	find src -name '*.gypi' -exec sed -i.bak "s/'python'/'python2'/g" {} \;
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
		unixemacs/emacs.gyp:mozc_emacs_helper || true
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
