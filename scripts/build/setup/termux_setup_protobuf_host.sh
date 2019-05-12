termux_setup_protobuf_host() {
	local _PROTOBUF_VERSION=$(bash -c ". $TERMUX_SCRIPTDIR/packages/libprotobuf/build.sh; echo \$TERMUX_PKG_VERSION")
	local _PROTOBUF_SHA256=$(bash -c ". $TERMUX_SCRIPTDIR/packages/libprotobuf/build.sh; echo \$TERMUX_PKG_SHA256")
	local _PROTOBUF_SRCURL=$(bash -c ". $TERMUX_SCRIPTDIR/packages/libprotobuf/build.sh; echo \$TERMUX_PKG_SRCURL")
	local _PROTOBUF_HOST_FOLDER=$TERMUX_COMMON_CACHEDIR/protobuf-$_PROTOBUF_VERSION-host

	if [ ! -d "$_PROTOBUF_HOST_FOLDER" ]; then
		termux_download \
				"$_PROTOBUF_SRCURL" \
				"$TERMUX_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION.tar.gz" \
				"$_PROTOBUF_SHA256"
		tar zxf "$TERMUX_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION.tar.gz" -C "$TERMUX_PKG_TMPDIR"
		termux_setup_cmake
		termux_setup_protobuf
		(cd "$TERMUX_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION" &&
		 mkdir build && cd build &&
		 cmake "-DCMAKE_INSTALL_PREFIX=$_PROTOBUF_HOST_FOLDER" -Dprotobuf_BUILD_TESTS=OFF ../cmake &&
		 make -j $TERMUX_MAKE_PROCESSES install)
	fi
}
