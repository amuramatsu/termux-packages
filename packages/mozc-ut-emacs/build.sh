TERMUX_PKG_HOMEPAGE=http://linuxplayers.g1.xrea.com/mozc-ut.html
TERMUX_PKG_DESCRIPTION="Japanese Input method with large dictionary (for emacs)"
TERMUX_PKG_LICENSE="GPL-3.0"
_MAJOR_VERSION=2.26.4486.102
_MINOR_VERSION=20210907
TERMUX_PKG_VERSION=$_MAJOR_VERSION.$_MINOR_VERSION
TERMUX_PKG_MAINTAINER="MURAMATSU Atsushi @amuramatsu"
TERMUX_PKG_SHA256=ff54af870892c9e5e1586e54dda805a27c3f61e32c0ef7f1bd6fe4a70b62f62d
TERMUX_PKG_SRCURL=https://osdn.net/users/utuhiro/pf/utuhiro/dl/mozc-$_MAJOR_VERSION.tar.bz2
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_DEPENDS="libc++, libprotobuf, libiconv"
TERMUX_PKG_BUILD_DEPENDS="protobuf"
TERMUX_PKG_HOSTBUILD=yes

_UTDIC_SRCURL=https://osdn.net/users/utuhiro/pf/utuhiro/dl/mozcdic-ut-$_MINOR_VERSION.tar.bz2
_UTDIC_SHA256=8a3642e12f26b63c93547a037e1910d1462863bc44c821fbe05a6f86197a5a93

_GYP_REPO=https://chromium.googlesource.com/external/gyp.git
_GYP_COMMIT=caa60026e223fc501e8b337fd5086ece4028b1c6
_ABSEIL_REPO=https://github.com/abseil/abseil-cpp.git
_ABSEIL_COMMIT=e1d388e7e74803050423d035e4374131b9b57919
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
	(cd src/third_party/gyp && git reset --hard $_GYP_COMMIT)
    	git clone $_ABSEIL_REPO src/third_party/abseil-cpp
	(cd src/third_party/abseil-cpp && git reset --hard $_ABSEIL_COMMIT)
	git clone $_JP_USAGE_DICT_REPO src/third_party/japanese_usage_dictionary
	(cd src/third_party/japanese_usage_dictionary && git reset --hard $_JP_USAGE_DICT_COMMIT)
	termux_download \
		$_UTDIC_SRCURL \
		mozcdic-ut-${_MINOR_VERSION}.tar.bz2 \
		$_UTDIC_SHA256
	tar jvxf mozcdic-ut-${_MINOR_VERSION}.tar.bz2
	cat mozcdic-ut-${_MINOR_VERSION}/mozcdic-*-${_MINOR_VERSION}.txt \
	    >> src/data/dictionary_oss/dictionary00.txt
	git clone $_MOZC_CONFIG_REPO mozc-config
	(cd mozc-config && git reset --hard $_MOZC_CONFIG_COMMIT)
	git clone $_MOZCTOROKU_REPO mozctoroku
	(cd mozctoroku && git reset --hard $_MOZCTOROKU_COMMIT)
	termux_setup_protobuf
}

termux_step_configure () {
        LDFLAGS="${LDFLAGS/-static-openmp/}"
        LDFLAGS="${LDFLAGS/-fopenmp/}"
	termux_setup_ninja
	cd "$TERMUX_PKG_SRCDIR/src"
	GYP_DEFINES="use_libprotobuf=1 include_dirs=$TERMUX_PREFIX/include library_dirs=$TERMUX_PREFIX/lib" \
	  python build_mozc.py gyp \
		--gypdir=$TERMUX_PKG_SRCDIR/src/third_party/gyp \
		--target_platform=Linux --noqt \
		--server_dir=$TERMUX_PREFIX/lib/mozc
}

termux_step_make () {
        LDFLAGS="${LDFLAGS/-static-openmp/}"
        LDFLAGS="${LDFLAGS/-fopenmp/}"
	cd "$TERMUX_PKG_SRCDIR/src"
	export PATH="${PATH}:$TERMUX_TOPDIR/libprotobuf/host-build/install/bin"
	python build_mozc.py build -c Release \
		server/server.gyp:mozc_server \
		unixemacs/emacs.gyp:mozc_emacs_helper || true
	cd "$TERMUX_PKG_SRCDIR/mozc-config"
	make mozc-config mozc-dict
}

termux_step_make_install () {
	local _release_dir=src/out_linux/Release
        local _doc_destdir="${TERMUX_PREFIX}/share/doc/mozc-ut-emacs"
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
