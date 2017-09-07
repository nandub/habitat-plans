pkg_name=c-ares
pkg_origin=nandub
pkg_version="1.13.0"
pkg_maintainer="Fernando Ortiz <nandub+habitat@nandub.info>"
pkg_license=('MIT')
pkg_upstream_ur="https://github.com/c-ares/c-ares"
pkg_description="A C library for asynchronous DNS requests"
pkg_source="https://c-ares.haxx.se/download/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=03f708f1b14a26ab26c38abd51137640cb444d3ec72380b21b20f1a8d2861da7
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
  CPPFLAGS="$CFLAGS"
  CFLAGS=""
  export CPPFLAGS CFLAGS
}

do_build() {
  ./configure --prefix="$pkg_prefix" \
      --disable-tests
  make
}
