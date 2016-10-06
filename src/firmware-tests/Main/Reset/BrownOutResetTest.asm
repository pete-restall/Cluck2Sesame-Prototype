	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern initialiseResetMocks
	extern main

BrownOutResetTest code
	global testArrange
	global testAssert

testArrange:
	fcall initialiseResetMocks

testAct:
	fcall main

testAssert:
	.assert "calledInitialiseAfterBrownOutReset != 0, 'BOR condition did not call initialiseAfterBrownOutReset.'"

	.assert "calledInitialiseAfterPowerOnReset == 0, 'BOR condition called initialiseAfterPowerOnReset.'"

	.assert "calledInitialiseAfterMclrReset == 0, 'BOR condition called initialiseAfterMclrReset.'"

	.done

	end
