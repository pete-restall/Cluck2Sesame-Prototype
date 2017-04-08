	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "MclrReset.inc"
	#include "ResetFlags.inc"
	#include "TestFixture.inc"

	radix decimal

IsBrownOutResetTest code
	global testArrange

testArrange:
	fcall initialiseAfterMclrReset

testAct:
	fcall isLastResetDueToBrownOut

testAssert:
	.assert "W == 0, 'Expected isLastResetDueToBrownOut() to return false.'"
	return

	end
