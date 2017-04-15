#!/bin/bash
mkdir gputils-trunk
cd gputils-trunk
svn checkout svn://svn.code.sf.net/p/gputils/code/trunk .
cd gputils
./configure --prefix=/usr
make
make install
