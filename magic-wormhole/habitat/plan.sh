pkg_name=magic-wormhole
pkg_origin=nandub
pkg_version="0.10.2"
pkg_maintainer="Fernando Ortiz <nandub+habitat@nandub.info>"
pkg_license=('MIT')
pkg_upstream_url=https://github.com/warner/magic-wormhole
pkg_source=https://github.com/warner/magic-wormhole/archive/${pkg_version}.tar.gz
pkg_shasum=e26b5649608b74f2d658849a3adecf74a9629c9f8ac86a29686abd5d3a0e0d56
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
  export SSL_CERT_FILE=$(hab pkg path core/cacerts)/ssl/cert.pem
  export LD_LIBRARY_PATH=$(hab pkg path core/libffi)/lib
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