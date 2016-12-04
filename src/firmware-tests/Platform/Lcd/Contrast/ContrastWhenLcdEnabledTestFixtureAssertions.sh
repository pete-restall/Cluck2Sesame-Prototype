#!/bin/bash
EXPECTED_MIN_DC_LEVEL="0.4";
EXPECTED_MAX_DC_LEVEL="0.6";

PORTA="0x0005";
BIT="1";

SAMPLE_FREQUENCY_HZ="1000000";
R_OHMS="1000";
C_FARADS="1e-5";

HALF_SECOND=$((${SAMPLE_FREQUENCY_HZ} / 2));

NORMALISED_MEAN=`cat ContrastWhenLcdEnabledTestFixture.log | ${GPSIM2TUPLE} ${PORTA} ${BIT} | ${LPF_RC} ${SAMPLE_FREQUENCY_HZ} ${R_OHMS} ${C_FARADS} | ${MEAN} ${HALF_SECOND} all`;

DC_LEVEL=`echo "3.3 * ${NORMALISED_MEAN}" | bc`;
WITHIN_BOUNDS=`echo "${DC_LEVEL} >= ${EXPECTED_MIN_DC_LEVEL} && ${DC_LEVEL} <= ${EXPECTED_MAX_DC_LEVEL}" | bc`;
if [ ${WITHIN_BOUNDS} -ne 0 ]; then
	echo "[PASSED] Contrast DC Level is ${DC_LEVEL}V";
else
	echo "[FAILED] Contrast DC Level is ${DC_LEVEL}V; expected ${EXPECTED_MIN_DC_LEVEL}V <= V <= ${EXPECTED_MAX_DC_LEVEL}V";
fi;
