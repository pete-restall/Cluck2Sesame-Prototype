	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	#include "../ResetMocks.inc"

	radix decimal

	extern main

BrownOutResetTest code
	global testArrange
	global testAssert

testArrange:
	fcall initialiseResetMocks

testAct:
	fcall main

testAssert:
	banksel calledInitialiseAfterBrownOutReset
	.assert "calledInitialiseAfterBrownOutReset != 0, 'BOR condition did not call initialiseAfterBrownOutReset.'"
	.assert "calledInitialiseAfterPowerOnReset == 0, 'BOR condition called initialiseAfterPowerOnReset.'"
	.assert "calledInitialiseAfterMclrReset == 0, 'BOR condition called initialiseAfterMclrReset.'"
	.done

	end
