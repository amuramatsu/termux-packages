TERMUX_PKG_HOMEPAGE=http://linuxplayers.g1.xrea.com/mozc-ut.html
TERMUX_PKG_DESCRIPTION="Japanese Input method with large dictionary (for emacs)"
TERMUX_PKG_LICENSE="GPL-3.0"
_MAJOR_VERSION=2.28.4880.102
_MINOR_VERSION=20221022
TERMUX_PKG_VERSION=$_MAJOR_VERSION.$_MINOR_VERSION
TERMUX_PKG_MAINTAINER="MURAMATSU Atsushi @amuramatsu"
TERMUX_PKG_SHA256=e5ff06e34c78996cb0b2468acdec4123d491cc97f264eeabcda4bcde795e2b20
TERMUX_PKG_SRCURL=https://osdn.net/users/utuhiro/pf/utuhiro/dl/mozc-$_MAJOR_VERSION.$_MINOR_VERSION.tar.bz2
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_DEPENDS="libc++, libandroid-posix-semaphore, libprotobuf, libiconv"
TERMUX_PKG_BUILD_DEPENDS="protobuf"
TERMUX_PKG_HOSTBUILD=true

_UTDIC_SRCURL=https://osdn.net/users/utuhiro/pf/utuhiro/dl/mozcdic-ut-$_MINOR_VERSION.tar.bz2
_UTDIC_SHA256=1012b6cf1e8e0e23e60910f0b9c0ca857836e70408ad6edaabba9803fb274b10

_MOZC_CONFIG_REPO=https://github.com/hidegit/mozc-config.git
_MOZC_CONFIG_COMMIT=79bd032431320dbb79d3e16d41686e5a58f22218
_MOZCTOROKU_REPO=https://github.com/amuramatsu/mozctoroku.git
_MOZCTOROKU_COMMIT=fb2f064c3a8e36df3f4a9115434d5564c9b551d8

termux_step_host_build() {
	local _PROTOBUF_VERSION=$(bash -c ". $TERMUX_SCRIPTDIR/packages/libprotobuf/build.sh; echo \${TERMUX_PKG_VERSION:2}")
	local _PROTOBUF_SHA256=$(bash -c ". $TERMUX_SCRIPTDIR/packages/libprotobuf/build.sh; echo \$TERMUX_PKG_SHA256")
	local _PROTOBUF_SRCURL=$(bash -c ". $TERMUX_SCRIPTDIR/packages/libprotobuf/build.sh; echo \$TERMUX_PKG_SRCURL")
	local _PROTOBUF_HOST_FOLDER=$TERMUX_PKG_HOSTBUILD_DIR/protobuf-host

	termux_download \
		"$_PROTOBUF_SRCURL" \
		"$TERMUX_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION.tar.gz" \
		"$_PROTOBUF_SHA256"
	tar zvxf "$TERMUX_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION.tar.gz" \
		-C "$TERMUX_PKG_SRCDIR"
	termux_setup_cmake
	termux_setup_protobuf
	(cd "$TERMUX_PKG_SRCDIR/protobuf-$_PROTOBUF_VERSION" &&
	 mkdir build && cd build &&
	 cmake "-DCMAKE_INSTALL_PREFIX=$_PROTOBUF_HOST_FOLDER" -Dprotobuf_BUILD_TESTS=OFF ../cmake &&
	 make -j $TERMUX_MAKE_PROCESSES install)
}

termux_step_post_get_source() {
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
        LDFLAGS+=" -landroid-posix-semaphore"
	termux_setup_ninja
	sed -i.bak "s,@TERMUX_PROTOBUF_HOST_ROOT@,$TERMUX_PKG_HOSTBUILD_DIR/protobuf-host,g" \
		"$TERMUX_PKG_SRCDIR/src/protobuf/protobuf.gyp"
	
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
        LDFLAGS+=" -landroid-posix-semaphore"
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
