	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern calledInitialiseAfterReset
	extern initialiseAfterPowerOnReset
	extern initialiseInitialiseAfterResetMock

InitialiseAfterResetCalledTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterResetMock

testAct:
	fcall initialiseAfterPowerOnReset

testAssert:
	.assert "calledInitialiseAfterReset != 0, 'Expected initialiseAfterReset to be called.'"

	.done

	end