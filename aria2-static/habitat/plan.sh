pkg_name=aria2-static
pkg_distname=aria2
pkg_origin=nandub
pkg_version=1.32.0
pkg_description="aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink."
pkg_upstream_url=https://github.com/aria2/aria2
pkg_maintainer="Fernando Ortiz <nandub+habitat@nandub.info>"
pkg_license=('gplv2')
pkg_source=https://github.com/aria2/aria2/releases/download/release-${pkg_version}/${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=af43688a7fa69f27b8d156b932accdaca847964b0853a62e133d8d84d2f9d0ca
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=()
pkg_build_deps=(
  nandub/c-ares
  core/cacerts
  core/coreutils
  core/pkg-config
  core/gcc
  core/libxml2
  core/libgcrypt
  core/libgpg-error
  core/make
  core/openssl
  core/zlib
)
pkg_bin_dirs=(bin)

do_build() {
  ./configure ARIA2_STATIC=yes \
      --prefix="$pkg_prefix" \
      --with-ca-bundle="$(pkg_path_for cacerts)/ssl/certs/cacert.pem"
  make
}
