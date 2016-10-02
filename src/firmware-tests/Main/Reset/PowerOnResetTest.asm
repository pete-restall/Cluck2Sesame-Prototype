	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern initialiseResetMocks
	extern main

PowerOnResetTest code
	global testArrange
	global testAssert

testArrange:
	fcall initialiseResetMocks

testAct:
	fcall main

testAssert:
	.assert "calledInitialiseAfterPowerOnReset != 0, \"POR condition did not call initialiseAfterPowerOnReset.\""

	.assert "calledInitialiseAfterBrownOutReset == 0, \"POR condition called initialiseAfterBrownOutReset.\""

	.assert "calledInitialiseAfterMclrReset == 0, \"POR condition called initialiseAfterMclrReset.\""

	.done

	end
