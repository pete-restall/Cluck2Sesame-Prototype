	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Isr.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterIsrMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterIsrMock

testAct:
	fcall initialiseIsr

testAssert:
	banksel calledInitialiseAfterIsr
	.assert "calledInitialiseAfterIsr != 0, 'Next initialiser in chain was not called.'"
	return

	end
