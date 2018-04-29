#!/bin/bash
mkdir gputils-trunk
cd gputils-trunk
svn checkout -r1311 svn://svn.code.sf.net/p/gputils/code/trunk .
cd gputils
./configure --prefix=/usr
make
make install
