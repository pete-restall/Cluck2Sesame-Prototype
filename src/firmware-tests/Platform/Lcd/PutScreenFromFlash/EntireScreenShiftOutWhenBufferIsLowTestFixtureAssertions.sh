#!/bin/bash
diff EntireScreenShiftOutWhenBufferIsLowTestFixture.hex EntireScreenShiftOutWhenBufferIsLowTestFixture.expectation
if [ $? -eq 0 ]; then
	echo "[PASSED"];
else
	echo "[FAILED]";
fi;
