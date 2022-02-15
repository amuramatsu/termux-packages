TERMUX_PKG_HOMEPAGE=https://github.com/KhronosGroup/OpenCL-CLHPP
TERMUX_PKG_DESCRIPTION="Khronos OpenCL C++ Headers"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.0.16
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/KhronosGroup/OpenCL-CLHPP/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=869456032e60787eed9fceaeaf6c6cb4452bc0ff97e0f5a271510145a1c8f4d4
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_EXAMPLES=OFF
-DBUILD_TESTS=OFF
"
