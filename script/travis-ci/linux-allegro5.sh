#!/bin/sh -e

build_allegro5() {
  local ALLEGRO="$1"
  local OPWD=`pwd`
  cd /tmp
  wget http://download.gna.org/allegro/allegro/5.2.1.1/allegro-5.2.1.1.7z
  7zr x *.7z
  cd allegro
  cmake \
   -DCMAKE_INSTALL_PREFIX=$ALLEGRO \
   .

  make -j 3 --keep-going install

  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$ALLEGRO"/lib
  export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:"$ALLEGRO"/lib/pkgconfig
  cd $OPWD
}

build_allegro_api() {
  local ALLEGRO="$1"
  local OPWD=`pwd`
  cd /tmp
  git clone \
    -b f/cppflags-write3bytes \
    https://github.com/bkil/allegro4-to-5.git

  cd allegro4-to-5

  make --keep-going V=1

  cp -at \
    $ALLEGRO/lib \
    build/allegro/liballegro4-to-5.a

  cp -at \
    $ALLEGRO/include \
    allegro4/allegro.h \
    allegro4/include

  export PATH=$PATH:$OPWD/script/travis-ci
  cd $OPWD
}

build_with_al5() {
  local ALLEGRO="$HOME/install/liballegro"
  build_allegro5 "$ALLEGRO"
  build_allegro_api "$ALLEGRO"

  autoconf

  local PREFIX="$HOME/install/liquid-war-5"

  ./configure --prefix="$PREFIX"
  make --keep-going
  make --keep-going install
  make --keep-going dist
}

build_with_al5 "$@"
