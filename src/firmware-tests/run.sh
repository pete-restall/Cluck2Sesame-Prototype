#!/bin/sh
GPSIM=gpsim;


# If no arguments given then run this script for each directory:

if [ $# != 1 ]; then
	for module in [ * ]; do
		if ! [[ -d ${module} ]]; then
			continue;
		fi;

		${0} ${module};
	done;
	exit;
fi;


# Run all of the tests for the module given on the command-line:

module="${1}";
for fixture in `find ${module} -name "*.stc"`; do
	fixtureDir=`dirname ${fixture}`;
	cod=`ls ${fixtureDir}/*.cod`;
	if [[ -a ${cod} ]]; then
		${GPSIM} -i -e onbreak -c ${fixture} -s ${cod};
	fi;
done;
