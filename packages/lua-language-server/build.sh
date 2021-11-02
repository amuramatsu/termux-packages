TERMUX_PKG_HOMEPAGE="https://github.com/sumneko/lua-language-server"
TERMUX_PKG_DESCRIPTION="Sumneko Lua Language Server coded in Lua"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="MrAdityaAlok <dev.aditya.alok@gmail.com>"
TERMUX_PKG_VERSION=2.4.5
TERMUX_PKG_SRCURL=https://github.com/sumneko/lua-language-server.git
TERMUX_PKG_GIT_BRANCH="${TERMUX_PKG_VERSION}"
TERMUX_PKG_BUILD_DEPENDS="libandroid-spawn"
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_BUILD_IN_SRC=true

# no cpu_relax support present for these archs.
# https://github.com/actboy168/bee.lua/blob/32f65b92739fa236d87fc1b2e7617470d47f0355/bee/thread/spinlock.h#L14
TERMUX_PKG_BLACKLISTED_ARCHES="arm,i686"

termux_step_host_build() {
	termux_setup_ninja

	mkdir 3rd
	cp -a "${TERMUX_PKG_SRCDIR}"/3rd/luamake 3rd/

	cd 3rd/luamake
	if [ "${TERMUX_ON_DEVICE_BUILD}" = true ]; then
		sed -i "s/-lstdc++/-lc++_static -lc++abi -landroid-spawn/g" ./compile/ninja/android.ninja
	fi
	./compile/install.sh
}

termux_step_make() {
	"${TERMUX_PKG_HOSTBUILD_DIR}"/3rd/luamake/luamake \
		-cc "${CC}" \
		-flags "${CFLAGS} ${CPPFLAGS}" \
		-hostos "android"
}

termux_step_make_install() {
	local INSTALL_DIR="${TERMUX_PREFIX}/lib/${TERMUX_PKG_NAME}"

	cat >"${TERMUX_PREFIX}/bin/${TERMUX_PKG_NAME}" <<-EOF
		#!${TERMUX_PREFIX}/bin/bash

		# After action of termux-elf-cleaner lua-language-server's binary(ELF) is unable to
		# determine its version, so provide it manually.
		if [ "\$1" = "--version" ]; then
			echo "${TERMUX_PKG_NAME}: ${TERMUX_PKG_VERSION}"
		else 
			TMPPATH=\$(mktemp -d "${TERMUX_PREFIX}/tmp/${TERMUX_PKG_NAME}.XXXX")

			exec ${INSTALL_DIR}/bin/Android/${TERMUX_PKG_NAME} \\
				--logpath="\${TMPPATH}/log" \\
				--metapath="\${TMPPATH}/meta" \\
				"\${@}"
		fi

	EOF

	chmod 744 "${TERMUX_PREFIX}/bin/${TERMUX_PKG_NAME}"

	install -Dm744 -t "${INSTALL_DIR}"/bin/Android ./bin/Android/"${TERMUX_PKG_NAME}"
	install -Dm644 -t "${INSTALL_DIR}" ./{main,debugger}.lua
	install -Dm644 -t "${INSTALL_DIR}"/bin/Android ./bin/Android/main.lua

	cp -r ./script ./meta ./locale "${INSTALL_DIR}"
}
