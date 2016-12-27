	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterCordicMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterCordicMock

testAct:
	fcall initialiseCordic

testAssert:
	banksel calledInitialiseAfterCordic
	.assert "calledInitialiseAfterCordic != 0, 'Next initialiser in chain was not called.'"
	return

	end
