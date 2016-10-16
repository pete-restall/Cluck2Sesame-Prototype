	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "MclrReset.inc"
	#include "TestFixture.inc"
	#include "InitialiseAfterResetMock.inc"

	radix decimal

InitialiseAfterResetCalledTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterResetMock

testAct:
	fcall initialiseAfterMclrReset

testAssert:
	.assert "calledInitialiseAfterReset != 0, 'Expected initialiseAfterReset to be called.'"
	return

	end
