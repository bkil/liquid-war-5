#!/bin/sh -e

maybe_build_allegro() {
  local ALLEGRO="$HOME/install/liballegro"
  export PATH=$PATH:"$ALLEGRO"/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$ALLEGRO"/lib

  if
    ! which allegro-config > /dev/null
  then
    build_allegro
  fi
}

build_allegro() {
  local OPWD=`pwd`
  cd /tmp

  apt-get source liballegro4.2-dev
  cd allegro4.2-*

  CFLAGS=-O0 \
  ./configure \
    --prefix=$ALLEGRO \
    `get_configure_disables`

  make -j 8 install

  cd $OPWD
}

get_configure_disables() {
  ./configure --help |
  grep -iE -- "--enable-" |
  grep -vE -- "\
--enable-(FEATURE|asm|color(8|16|24|32)|shared|stdlib|opts|exclopts|mmx|sse|constructor|modules)\
" |
  cut -d " " -f 3 |
  sed -r "s~=x$~=no~"
}

maybe_build_allegro "$@"

