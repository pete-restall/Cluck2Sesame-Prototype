#!/bin/bash
GPSIM=gpsim;
UTILITIES_BASEDIR="`readlink -e ../utilities`";

export GPSIM2TUPLE="${UTILITIES_BASEDIR}/gpsim2tuple/gpsim2tuple";
export LPF_RC="${UTILITIES_BASEDIR}/lpf-rc/lpf-rc";
export MEAN="${UTILITIES_BASEDIR}/mean/mean";


# If no arguments given then run this script for each directory:

if [ $# != 1 ]; then
	echo > run.log.all;
	exitCode=0;
	for module in [ * ]; do
		if ! [[ -d ${module} ]]; then
			continue;
		fi;

		${0} ${module} | tee -a run.log.all;
		if [ ${PIPESTATUS[0]} -ne 0 ]; then exitCode=3; fi
	done;
	exit ${exitCode};
fi;


# Run all of the tests for the module given on the command-line:

module="${1}";
runLog="run.log";
tee="tee -a ${runLog}";
echo > ${runLog};
for fixture in `find ${module} -name "*.stc"`; do
	runTest="${GPSIM} -i -c ${fixture}";
	echo "${runTest};";
	${runTest} | ${tee};
done;

for assertions in `find ${module} -name "*TestFixtureAssertions.sh"`; do
	assertionsScript="`basename ${assertions}`";
	assertionsDirectory="`dirname ${assertions}`";
	runAssertions="./${assertionsScript}";
	echo "${runAssertions};";
	pushd .;
	cd ${assertionsDirectory};
	${runAssertions} | ${tee};
	popd;
done;

passedTestCount=`cat ${runLog} | grep "\[PASSED\]" | wc -l`;
totalTestCount=`cat ${runLog} | grep "gpsim - the GNUPIC simulator" | wc -l`;
spuriousFailureCount=`cat ${runLog} | grep "ERROR" | wc -l`;

if [ ${passedTestCount} -eq ${totalTestCount} ]; then
	if [ ${spuriousFailureCount} -eq 0 ]; then
		exitCode=0;
		result="SUCCESS";
	else
		exitCode=2;
		result="FAILURE";
	fi;
else
	exitCode=1;
	result="FAILURE";
fi

echo "[RESULT: ${result}] ${totalTestCount} tests run for module ${module}, ${passedTestCount} of which passed.  There were ${spuriousFailureCount} gpsim errors that didn't trigger breakpoints.";

exit ${exitCode};
