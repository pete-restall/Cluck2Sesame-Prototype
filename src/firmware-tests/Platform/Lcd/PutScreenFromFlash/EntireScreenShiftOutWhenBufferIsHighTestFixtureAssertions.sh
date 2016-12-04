#!/bin/bash
diff EntireScreenShiftOutWhenBufferIsHighTestFixture.hex EntireScreenShiftOutWhenBufferIsHighTestFixture.expectation
if [ $? -eq 0 ]; then
	echo "[PASSED"];
else
	echo "[FAILED]";
fi;
