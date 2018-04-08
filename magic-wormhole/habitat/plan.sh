pkg_name=magic-wormhole
pkg_origin=nandub
pkg_version="0.10.3"
pkg_maintainer="Fernando Ortiz <nandub+habitat@nandub.info>"
pkg_license=('MIT')
pkg_upstream_url=https://github.com/warner/magic-wormhole
pkg_source=https://github.com/warner/magic-wormhole/archive/${pkg_version}.tar.gz
pkg_shasum=b983585c53c9ea09e0320d4a1473dba104aee9f5683fd0afbda022d9fa65bb1d
pkg_build_deps=(
  core/cacerts
  core/gcc
  core/libffi
  core/make
  core/openssl
  core/python2
)
pkg_deps=(
  core/libffi
  core/openssl
  core/python2
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_prepare() {
  export SSL_CERT_FILE=$(pkg_path_for cacerts)/ssl/cert.pem
  export LD_LIBRARY_PATH=$(pkg_path_for libffi)/lib
}

do_build() {
  return 0
} 

do_install() {
  export PYTHONPATH="$pkg_prefix/lib/python2.7/site-packages/"
  mkdir -p "$PYTHONPATH"
  python -m pip download --no-binary :all: pyasn1
  file=$(ls -1 pyasn1-*)
  tar xf $file
  pushd pyasn1-*
    python setup.py install --prefix="$pkg_prefix"
  popd
  python setup.py install --prefix="$pkg_prefix"

  # Modify the command to have the correct PYTHONPATH
  sed -i "2iimport sys; sys.path.append(\"$PYTHONPATH\")" "$pkg_prefix/bin/wormhole"
  sed -i "2iimport sys; sys.path.append(\"$PYTHONPATH\")" "$pkg_prefix/bin/wormhole-server"
}
