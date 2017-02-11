#!/bin/bash
for libName in $*; do
	libName=`readlink -e ${libName}`;
	dirName=`basename ${libName} .a`;
	libEntries=`gplib -t ${libName} | sed "s/^\(.\+\.o\).\+/\1/g"`;
	mkdir ${dirName};
	cd ${dirName};
	for libEntry in ${libEntries}; do
		gplib -x ${libName} ${libEntry};
		if [ -e ${libEntry} ]; then
			mv ${libEntry} ${dirName}_${libEntry};
		else
			mv ${libEntry}.o ${dirName}_${libEntry};
		fi;
	done;
	cd ..;
done;
