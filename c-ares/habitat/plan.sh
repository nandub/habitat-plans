pkg_name=c-ares
pkg_origin=nandub
pkg_version="1.14.0"
pkg_maintainer="Fernando Ortiz <nandub+habitat@nandub.info>"
pkg_license=('MIT')
pkg_upstream_url="https://github.com/c-ares/c-ares"
pkg_description="A C library for asynchronous DNS requests"
pkg_source="https://c-ares.haxx.se/download/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=45d3c1fd29263ceec2afc8ff9cd06d5f8f889636eb4e80ce3cc7f0eaf7aadc6e
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/file
  core/gcc
  core/make
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  # c-ares only allows CFLAGS to set CC.
  unset CFLAGS
}

do_build() {
  ./configure --prefix="$pkg_prefix" \
      --disable-tests
  make
}
