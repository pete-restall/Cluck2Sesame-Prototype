	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "BrownOutReset.inc"
	#include "ResetFlags.inc"
	#include "TestFixture.inc"

	radix decimal

IsBrownOutResetTest code
	global testArrange

testArrange:
	fcall initialiseAfterBrownOutReset

testAct:
	fcall isLastResetDueToBrownOut

testAssert:
	.assert "W != 0, 'Expected isLastResetDueToBrownOut() to return true.'"
	return

	end
