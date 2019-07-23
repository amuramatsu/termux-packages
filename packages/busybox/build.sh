TERMUX_PKG_HOMEPAGE=https://busybox.net/
TERMUX_PKG_DESCRIPTION="Tiny versions of many common UNIX utilities into a single small executable"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.30.1
TERMUX_PKG_REVISION=7
TERMUX_PKG_SRCURL=https://busybox.net/downloads/busybox-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=3d1d04a4dbd34048f4794815a5c48ebb9eb53c5277e09ffffc060323b95dfbdc
TERMUX_PKG_BUILD_IN_SRC=yes

# We replace env in the old coreutils package:
TERMUX_PKG_CONFLICTS="coreutils (<< 8.25-4)"

termux_step_pre_configure() {
	CFLAGS+=" -llog" # Android system liblog.so for syslog
}

termux_step_configure() {
	cp $TERMUX_PKG_BUILDER_DIR/busybox.config .config
	echo "CONFIG_SYSROOT=\"$TERMUX_STANDALONE_TOOLCHAIN/sysroot\"" >> .config
	echo "CONFIG_PREFIX=\"$TERMUX_PREFIX\"" >> .config
	echo "CONFIG_CROSS_COMPILER_PREFIX=\"${TERMUX_HOST_PLATFORM}-\"" >> .config
	echo "CONFIG_FEATURE_CROND_DIR=\"$TERMUX_PREFIX/var/spool/cron\"" >> .config
	echo "CONFIG_SV_DEFAULT_SERVICE_DIR=\"$TERMUX_PREFIX/var/service\"" >> .config
	make oldconfig
}

termux_step_post_make_install() {
	if [ "$TERMUX_DEBUG" == "true" ]; then
		install busybox_unstripped $PREFIX/bin/busybox
	fi

	# Utilities diff, mv, rm, rmdir are necessary to assist with package upgrading
	# after https://github.com/termux/termux-packages/issues/4070.
	#
	# Other utilities (like crond/crontab) are useful but not available
	# as standalone package in Termux.
	#
	# Few notes:
	#
	#  * runsv, runsvdir, sv - for things like in https://github.com/termux/termux-packages/pull/3460.
	#  * tcpsvd - required for ftpd applet.
	#  * vi - replaced by vim, but it still good to have basic text editor in bootstrap.
	#  * which - replaced by debianutils, but still good to have in bootstrap.
	#
	rm -Rf $TERMUX_PREFIX/bin/applets
	mkdir -p $TERMUX_PREFIX/bin/applets
	cd $TERMUX_PREFIX/bin/applets
	for f in crond crontab diff ftpd ftpget ftpput hostname inotifyd \
		iostat lsof lsusb mpstat mv nmeter rm rmdir runsv runsvdir \
		sendmail start-stop-daemon sv svlogd tcpsvd uptime usleep \
		vi which; do
		ln -s ../busybox $f
	done
	unset f

	# Install busybox man page
	mkdir -p $TERMUX_PREFIX/share/man/man1
	cp $TERMUX_PKG_SRCDIR/docs/busybox.1 $TERMUX_PREFIX/share/man/man1

	# Needed for 'crontab -e' to work out of the box:
	local _CRONTABS=$TERMUX_PREFIX/var/spool/cron/crontabs
	mkdir -p $_CRONTABS
	echo "Used by the busybox crontab and crond tools" > $_CRONTABS/README.termux

	# Setup some services
	mkdir -p $TERMUX_PREFIX/var/service
	cd $TERMUX_PREFIX/var/service
	mkdir -p ftpd telnetd
	echo '#!/bin/sh' > ftpd/run
	echo 'exec busybox tcpsvd -vE 0.0.0.0 8021 ftpd /data/data/com.termux/files/home' >> ftpd/run
	echo '#!/bin/sh' > telnetd/run
	echo 'exec busybox telnetd -F' >> telnetd/run
	chmod +x */run
}

