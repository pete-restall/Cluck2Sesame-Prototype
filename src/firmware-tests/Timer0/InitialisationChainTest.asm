	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "TestFixture.inc"
	#include "InitialiseAfterTimer0Mock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterTimer0Mock

testAct:
	fcall initialiseTimer0

testAssert:
	.assert "calledInitialiseAfterTimer0 != 0, 'Next initialiser in chain was not called.'"
	return

	end
