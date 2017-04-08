	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	#include "../ResetMocks.inc"

	radix decimal

	extern main

MclrResetTest code
	global testArrange
	global testAssert

testArrange:
	fcall initialiseResetMocks

testAct:
	fcall main

testAssert:
	banksel calledInitialiseAfterMclrReset
	.assert "calledInitialiseAfterMclrReset != 0, 'MCLR condition did not call initialiseAfterMclrReset.'"
	.assert "calledInitialiseAfterPowerOnReset == 0, 'MCLR condition called initialiseAfterPowerOnReset.'"
	.assert "calledInitialiseAfterBrownOutReset == 0, 'MCLR condition called initialiseAfterBrownOutReset.'"
	.done

	end
