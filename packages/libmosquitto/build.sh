TERMUX_PKG_HOMEPAGE=https://mosquitto.org/
TERMUX_PKG_DESCRIPTION="MQTT library"
TERMUX_PKG_LICENSE="EPL-1.0"
TERMUX_PKG_MAINTAINER="Nathaniel Wesley Filardo @nwf"
TERMUX_PKG_VERSION=1.6.3
TERMUX_PKG_SHA256=9ef5cc75f4fe31d7bf50654ddf4728ad9e1ae2e5609a4b42ecbbcb4a209ed17e
TERMUX_PKG_SRCURL=https://mosquitto.org/files/source/mosquitto-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_DEPENDS="c-ares, libc++, libwebsockets, openssl"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_THREADING=OFF
-DWITH_TLS_PSK=OFF
-DWITH_WEBSOCKETS=ON"
