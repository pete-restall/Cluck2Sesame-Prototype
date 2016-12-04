	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Clock.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterClockMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterClockMock

testAct:
	fcall initialiseClock

testAssert:
	banksel calledInitialiseAfterClock
	.assert "calledInitialiseAfterClock != 0, 'Next initialiser in chain was not called.'"
	return

	end
