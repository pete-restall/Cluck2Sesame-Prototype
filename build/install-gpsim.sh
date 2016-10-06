#!/bin/bash
mkdir gpsim-trunk
cd gpsim-trunk
svn checkout svn://svn.code.sf.net/p/gpsim/code/trunk .
libtoolize --force
aclocal
autoheader
automake --force-missing --add-missing
patch src/Makefile.in < ../gpsim-patch/src/Makefile.in.patch
autoconf
./configure --disable-gui --prefix=/usr
make
make install
