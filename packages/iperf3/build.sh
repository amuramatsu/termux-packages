TERMUX_PKG_HOMEPAGE=https://github.com/esnet/iperf
TERMUX_PKG_DESCRIPTION="TCP, UDP, and SCTP network bandwidth measurement tool"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=3.9
TERMUX_PKG_SRCURL=https://fossies.org/linux/privat/iperf-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=24b63a26382325f759f11d421779a937b63ca1bc17c44587d2fcfedab60ac038
TERMUX_PKG_DEPENDS="openssl"
TERMUX_PKG_BREAKS="iperf3-dev"
TERMUX_PKG_REPLACES="iperf3-dev"
