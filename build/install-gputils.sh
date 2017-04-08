#!/bin/bash
mkdir gputils-trunk
cd gputils-trunk
svn checkout svn://svn.code.sf.net/p/gputils/code/trunk .
patch gputils/libgputils/gpwriteobj.c < ../gputils-patch/gputils/libgputils/gpwriteobj.c.patch
cd gputils
./configure --prefix=/usr
make
make install
