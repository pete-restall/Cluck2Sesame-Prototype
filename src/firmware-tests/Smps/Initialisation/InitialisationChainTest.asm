	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterSmpsMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterSmpsMock

testAct:
	fcall initialiseSmps

testAssert:
	banksel calledInitialiseAfterSmps
	.assert "calledInitialiseAfterSmps != 0, 'Next initialiser in chain was not called.'"
	return

	end
