#!/bin/bash
mkdir gpsim-trunk
cd gpsim-trunk
svn checkout svn://svn.code.sf.net/p/gpsim/code/trunk .
libtoolize --force
aclocal
autoheader
automake --force-missing --add-missing
autoconf
./configure --disable-gui
make
make install
