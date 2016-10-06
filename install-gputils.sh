#!/bin/bash
mkdir gputils-trunk
cd gputils-trunk
svn checkout svn://svn.code.sf.net/p/gputils/code/trunk .
./configure
make
make install
