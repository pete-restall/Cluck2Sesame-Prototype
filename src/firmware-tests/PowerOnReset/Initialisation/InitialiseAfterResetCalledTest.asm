	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "PowerOnReset.inc"
	#include "TestFixture.inc"
	#include "InitialiseAfterResetMock.inc"

	radix decimal

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
