pkg_name=aria2
pkg_origin=nandub
pkg_version=1.32.0
pkg_description="aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink."
pkg_upstream_url=https://github.com/aria2/aria2
pkg_maintainer="Fernando Ortiz <nandub+habitat@nandub.info>"
pkg_license=('gplv2')
pkg_source=https://github.com/aria2/aria2/releases/download/release-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=af43688a7fa69f27b8d156b932accdaca847964b0853a62e133d8d84d2f9d0ca
pkg_deps=(
  core/cacerts
  core/gcc-libs
  core/libxml2
  core/libgcrypt
  core/libgpg-error
  core/openssl
  core/zlib
)
pkg_build_deps=(
  core/pkg-config
  core/coreutils
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure --prefix="$pkg_prefix" \
              --with-ca-bundle="$(pkg_path_for cacerts)/ssl/certs/cacert.pem" \
              --enable-libaria2 \
              --enable-static

  make
}
