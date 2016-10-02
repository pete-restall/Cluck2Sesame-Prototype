	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern initialiseResetMocks
	extern main

	global testArrange
	global testAssert

	code
testArrange:
	fcall initialiseResetMocks

testAct:
	fcall main

testAssert:
	.assert "calledInitialiseAfterMclrReset != 0, \"MCLR condition did not call initialiseAfterMclrReset.\""

	.assert "calledInitialiseAfterPowerOnReset == 0, \"MCLR condition called initialiseAfterPowerOnReset.\""

	.assert "calledInitialiseAfterBrownOutReset == 0, \"MCLR condition called initialiseAfterBrownOutReset.\""

	.done

	end
