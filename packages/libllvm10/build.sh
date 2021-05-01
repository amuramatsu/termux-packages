TERMUX_PKG_HOMEPAGE=https://clang.llvm.org/
TERMUX_PKG_DESCRIPTION="Modular compiler and toolchain technologies library"
TERMUX_PKG_LICENSE="NCSA"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=10.0.1
TERMUX_PKG_REVISION=4
TERMUX_PKG_SHA256=c5d8e30b57cbded7128d78e5e8dad811bff97a8d471896812f57fa99ee82cdf3
TERMUX_PKG_SRCURL=https://github.com/llvm/llvm-project/releases/download/llvmorg-$TERMUX_PKG_VERSION/llvm-$TERMUX_PKG_VERSION.src.tar.xz
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_DEPENDS="binutils, libc++, ncurses, ndk-sysroot, libffi, zlib"
# Replace gcc since gcc is deprecated by google on android and is not maintained upstream.
# Conflict with clang versions earlier than 3.9.1-3 since they bundled llvm.
TERMUX_PKG_CONFLICTS="gcc, clang (<< 3.9.1-3)"
TERMUX_PKG_BREAKS="libllvm10-dev"
TERMUX_PKG_REPLACES="gcc, libllvm10-dev"
# See http://llvm.org/docs/CMake.html:
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_PREFIX=$TERMUX_PREFIX/opt/llvm10
-DPYTHON_EXECUTABLE=$(which python3)
-DLLVM_ENABLE_PIC=ON
-DLLVM_ENABLE_LIBEDIT=OFF
-DLLVM_INCLUDE_TESTS=OFF
-DCLANG_DEFAULT_CXX_STDLIB=libc++
-DCLANG_INCLUDE_TESTS=OFF
-DCLANG_TOOL_C_INDEX_TEST_BUILD=OFF
-DDEFAULT_SYSROOT=$(dirname $TERMUX_PREFIX)
-DLLVM_LINK_LLVM_DYLIB=ON
-DLLVM_TABLEGEN=$TERMUX_PKG_HOSTBUILD_DIR/bin/llvm-tblgen
-DLIBOMP_ENABLE_SHARED=FALSE
-DOPENMP_ENABLE_LIBOMPTARGET=OFF
-DLLVM_BINUTILS_INCDIR=$TERMUX_PREFIX/include
-DLLVM_ENABLE_SPHINX=ON
-DSPHINX_OUTPUT_MAN=ON
-DLLVM_TARGETS_TO_BUILD=all
-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=AVR;RISCV
-DPERL_EXECUTABLE=$(which perl)
-DLLVM_ENABLE_FFI=ON
-DANDROID_NDK_VERSION=${TERMUX_NDK_VERSION_NUM}
"

if [ $TERMUX_ARCH_BITS = 32 ]; then
	# Do not set _FILE_OFFSET_BITS=64
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_FORCE_SMALLFILE_FOR_ANDROID=on"
fi

TERMUX_PKG_FORCE_CMAKE=true
TERMUX_PKG_HAS_DEBUG=false

termux_step_host_build() {
	termux_setup_cmake
	termux_setup_ninja

	cmake -G Ninja $TERMUX_PKG_SRCDIR
	ninja -j $TERMUX_MAKE_PROCESSES clang-tblgen llvm-tblgen
}

termux_step_pre_configure() {
	export LLVM_DEFAULT_TARGET_TRIPLE=$TERMUX_HOST_PLATFORM
	export LLVM_TARGET_ARCH
	if [ $TERMUX_ARCH = "arm" ]; then
		LLVM_TARGET_ARCH=ARM
	elif [ $TERMUX_ARCH = "aarch64" ]; then
		LLVM_TARGET_ARCH=AArch64
	elif [ $TERMUX_ARCH = "i686" ]; then
		LLVM_TARGET_ARCH=X86
	elif [ $TERMUX_ARCH = "x86_64" ]; then
		LLVM_TARGET_ARCH=X86
	else
		termux_error_exit "Invalid arch: $TERMUX_ARCH"
	fi
	# see CMakeLists.txt and tools/clang/CMakeLists.txt
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_TARGET_ARCH=$LLVM_TARGET_ARCH"
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_HOST_TRIPLE=$LLVM_DEFAULT_TARGET_TRIPLE"
}

termux_step_post_make_install() {
	if [ "$TERMUX_CMAKE_BUILD" = Ninja ]; then
		ninja docs-llvm-man
	else
		make docs-llvm-man
	fi

	mkdir -p $TERMUX_PREFIX/opt/llvm10/share/man/man1
	cp docs/man/* $TERMUX_PREFIX/opt/llvm10/share/man/man1
}

termux_step_post_massage() {
	# Not added to the package but kept around on the host for other packages like rust,
	# which relies on LLVM, to use for configuration.
	sed $TERMUX_PKG_BUILDER_DIR/llvm-config.in \
		-e "s|@TERMUX_PKG_VERSION@|$TERMUX_PKG_VERSION|g" \
		-e "s|@TERMUX_PKG_SRCDIR@|$TERMUX_PKG_SRCDIR|g" \
		-e "s|@LLVM_DEFAULT_TARGET_TRIPLE@|$LLVM_DEFAULT_TARGET_TRIPLE|g" \
		-e "s|@TERMUX_PREFIX@|$TERMUX_PREFIX/opt/llvm10|g" > $TERMUX_PREFIX/opt/llvm10/bin/llvm-config
	chmod 755 $TERMUX_PREFIX/opt/llvm10/bin/llvm-config
}
