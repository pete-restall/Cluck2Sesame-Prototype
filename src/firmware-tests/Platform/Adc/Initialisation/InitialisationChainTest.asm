	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Adc.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterAdcMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterAdcMock

testAct:
	fcall initialiseAdc

testAssert:
	banksel calledInitialiseAfterAdc
	.assert "calledInitialiseAfterAdc != 0, 'Next initialiser in chain was not called.'"
	return

	end
