#!/bin/bash
if [ $# -lt 2 ]; then
	echo "Usage: $0 <library.a> <obj1.o|a> [obj2.o|a] ...";
	exit;
fi;

touch $1;
libName=`readlink -e $1`;
utilitiesDir="`dirname $0`";
tempDir="`mktemp -d`";
cp ${@:2} ${tempDir};
cd $tempDir;
${utilitiesDir}/gplib-extract.sh `ls *.a`;
gplib -c ${libName} `find ./ -iname "*.o"`;
