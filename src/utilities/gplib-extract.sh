#!/bin/bash
for libName in $*; do
	libName=`readlink -e ${libName}`;
	dirName=`basename ${libName} .a`;
	libEntries=`gplib -t ${libName} | sed "s/^\(.\+\.o\).\+/\1/g"`;
	mkdir ${dirName};
	cd ${dirName};
	for libEntry in ${libEntries}; do
		gplib -x ${libName} ${libEntry};
		mv ${libEntry}.o ${dirName}_${libEntry};
	done;
	cd ..;
done;
