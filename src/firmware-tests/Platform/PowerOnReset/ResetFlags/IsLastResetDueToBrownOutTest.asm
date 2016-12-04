	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "PowerOnReset.inc"
	#include "ResetFlags.inc"
	#include "TestFixture.inc"

	radix decimal

IsBrownOutResetTest code
	global testArrange

testArrange:
	fcall initialiseAfterPowerOnReset

testAct:
	fcall isLastResetDueToBrownOut

testAssert:
	.assert "W == 0, 'Expected isLastResetDueToBrownOut() to return false.'"
	return

	end
