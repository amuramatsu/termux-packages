TERMUX_PKG_HOMEPAGE=http://www.boxedwine.org/
TERMUX_PKG_DESCRIPTION="Boxedwine is an emulator that runs Windows applications. It achieves this by running an unmodified 32-bit version of Wine, and emulating the Linux kernel and CPU."
TERMUX_PKG_LICENSE="GPL-2"
TERMUX_PKG_LICENSE_FILE="license.txt"
TERMUX_PKG_MAINTAINER="@termux"
_GIT_HASH=ecd8e08142fb8c956d8d9e136a1c6f6597a514d0
TERMUX_PKG_VERSION=21.0.1.20230216.${_GIT_HASH}
TERMUX_PKG_SRCURL=https://github.com/danoon2/Boxedwine/archive/${_GIT_HASH}.zip
TERMUX_PKG_SHA256=0cefa32ec9ff527d659539dcc8e18848a1bca0ba50c84f05cb649074eeb0d02f
TERMUX_PKG_DEPENDS="sdl2, glu, openssl, boost, libminizip, pulseaudio, libx11"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
	termux_setup_cmake
}

termux_step_make() {
	BUILD_TYPE=Release
	test "$TERMUX_DEBUG_BUILD" == "true" && BUILD_TYPE=Debug
	CMAKE_PROC=$TERMUX_ARCH
	uname_m=$TERMUX_ARCH
	if [ $TERMUX_ARCH = arm ]; then
		uname_m=armv7l
		CMAKE_PROC=armv7-a
	fi

	if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
		CXXFLAGS+=" --target=$CCTERMUX_HOST_PLATFORM"
		CFLAGS+=" --target=$CCTERMUX_HOST_PLATFORM"
		LDFLAGS+=" --target=$CCTERMUX_HOST_PLATFORM"
	fi
	MAKE_PROGRAM_PATH=$(command -v make)
	BUILD_POCOLIB_ARGS="
		-DCMAKE_AR=\"$(command -v $AR)\"
		-DCMAKE_UNAME=\"$(command -v uname)\"
		-DCMAKE_RANLIB=\"$(command -v $RANLIB)\"
		-DCMAKE_STRIP=\"$(command -v $STRIP)\"
		-DCMAKE_BUILD_TYPE=$BUILD_TYPE \
		-DCMAKE_C_FLAGS=\"$CFLAGS $CPPFLAGS\"
		-DCMAKE_CXX_FLAGS=\"$CXXFLAGS $CPPFLAGS\"
		-DCMAKE_FIND_ROOT_PATH=$TERMUX_PREFIX
		-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER
		-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY
		-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY
		-DCMAKE_INSTALL_PREFIX=$TERMUX_PREFIX
		-DCMAKE_INSTALL_LIBDIR=$TERMUX_PREFIX/lib
		-DCMAKE_MAKE_PROGRAM=$MAKE_PROGRAM_PATH
		-DCMAKE_SKIP_INSTALL_RPATH=ON
		-DCMAKE_USE_SYSTEM_LIBRARIES=True
		-DDOXYGEN_EXECUTABLE=
		-DBUILD_TESTING=OFF
	"
	if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
		BUILD_POCOLIB_ARGS="$BUILD_POCOLIB_ARGS
			-DCMAKE_CROSSCOMPILING=True
			-DCMAKE_LINKER=\"$TERMUX_STANDALONE_TOOLCHAIN/bin/$LD $LDFLAGS\"
			-DCMAKE_SYSTEM_NAME=Android
			-DCMAKE_SYSTEM_VERSION=$TERMUX_PKG_API_LEVEL
			-DCMAKE_SYSTEM_PROCESSOR=$CMAKE_PROC
			-DCMAKE_ANDROID_STANDALONE_TOOLCHAIN=$TERMUX_STANDALONE_TOOLCHAIN
		"
	else
		BUILD_POCOLIB_ARGS="$BUILD_POCOLIB_ARGS
			-DCMAKE_LINKER=\"$(command -v $LD) $LDFLAGS\"
		"
	fi

	cd ./project/linux
	if [ $TERMUX_ARCH = "aarch64" -o $TERMUX_ARCH = "x86_64" ]; then
		make multiThreaded uname_n=raspberrypi uname_m=${uname_m} \
			"BUILD_POCOLIB_ARGS=${BUILD_POCOLIB_ARGS}"
	else
		make jit uname_n=raspberrypi uname_m=${uname_m} \
			"BUILD_POCOLIB_ARGS=${BUILD_POCOLIB_ARGS}"
	fi
}

termux_step_make_install() {
	cd ./project/linux
	if [ $TERMUX_ARCH = "aarch64" -o $TERMUX_ARCH = "x86_64" ]; then
		cp Build/MultiThreaded/boxedwine ${TERMUX_PREFIX}/bin
	else
		cp Build/Jit/boxedwine ${TERMUX_PREFIX}/bin
	fi
	cd ../..
	local _DOCPATH="${TERMUX_PREFIX}/share/doc/${TERMUX_PKG_NAME}"
	mkdir -p "${_DOCPATH}"
	cp README.md changeLog.txt commandLine.txt docs/* "${_DOCPATH}"
}
