TERMUX_PKG_HOMEPAGE=https://www.erlang.org/
TERMUX_PKG_DESCRIPTION="General-purpose concurrent functional programming language"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="26.2.4"
TERMUX_PKG_SRCURL=https://github.com/erlang/otp/archive/OTP-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=c3bd54ee83282764f3c236e3aa49d681bac0b4011242e3512d66a7ee2ed79819
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_VERSION_REGEXP='\d+(\.\d+)+'
TERMUX_PKG_DEPENDS="libc++, openssl, ncurses, zlib"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--without-javac
--with-ssl=${TERMUX_PREFIX}
--with-termcap
erl_xcomp_sysroot=${TERMUX_PREFIX}
"
termux_pkg_auto_update() {
	# Get latest release tag:
	local tag
	tag="$(termux_github_api_get_tag "${TERMUX_PKG_SRCURL}")"
	# check if this is not an intermediate release candidate:
	if grep -qP "^OTP-${TERMUX_PKG_UPDATE_VERSION_REGEXP}\$" <<<"$tag"; then
		termux_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not stable release($tag)"
	fi
}

termux_step_post_get_source() {
	# We need a host build every time, because we dont know the full output of host build and have no idea to cache it.
	rm -Rf "$TERMUX_PKG_HOSTBUILD_DIR"
}

termux_step_host_build() {
	cd $TERMUX_PKG_BUILDDIR
	# Erlang cross compile reference: https://github.com/erlang/otp/blob/master/HOWTO/INSTALL-CROSS.md#building-a-bootstrap-system
	# Build erlang bootstrap system.
	./configure --enable-bootstrap-only --without-javac --without-ssl --without-termcap
	make -j $TERMUX_MAKE_PROCESSES
}

termux_step_pre_configure() {
	# Add --build flag for erlang cross build
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --build=$(./erts/autoconf/config.guess)"

	# Use a wrapper CC to move `-I@TERMUX_PREFIX@/include` to the last include param
	mkdir -p $TERMUX_PKG_TMPDIR/_fake_bin
	sed -e "s|@TERMUX_PREFIX@|${TERMUX_PREFIX}|g" \
		-e "s|@COMPILER@|$(command -v ${CC})|g" \
		"$TERMUX_PKG_BUILDER_DIR"/wrapper.py.in \
		> $TERMUX_PKG_TMPDIR/_fake_bin/"$(basename ${CC})"
	chmod +x $TERMUX_PKG_TMPDIR/_fake_bin/"$(basename ${CC})"
	export PATH="$TERMUX_PKG_TMPDIR/_fake_bin:$PATH"
}
