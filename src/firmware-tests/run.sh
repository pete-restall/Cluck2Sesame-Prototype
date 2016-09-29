#!/bin/sh
GPSIM=gpsim;


# If no arguments given then run this script for each directory:

if [ $# != 1 ]; then
	exitCode=0;
	for module in [ * ]; do
		if ! [[ -d ${module} ]]; then
			continue;
		fi;

		${0} ${module};
		if [ $? -ne 0 ]; then exitCode=1; fi
	done;
	exit ${exitCode};
fi;


# Run all of the tests for the module given on the command-line:

module="${1}";
echo > run.log;
for fixture in `find ${module} -name "*.stc"`; do
	runTest="${GPSIM} -i -e onbreak -c ${fixture}";
	echo "${runTest};";
	${runTest} | tee -a run.log;
done;
failedTestCount=`cat run.log | grep "Hit a Breakpoint" | wc -l`;
totalTestCount=`cat run.log | grep "gpsim - the GNUPIC simulator" | wc -l`;

echo "${totalTestCount} tests run for module ${module}, ${failedTestCount} of which failed";

if [ $failedTestCount -eq 0 ]; then
	exit 0;
else
	exit 1;
fi
