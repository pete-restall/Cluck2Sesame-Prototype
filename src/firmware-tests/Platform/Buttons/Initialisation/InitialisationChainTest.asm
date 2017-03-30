	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Buttons.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterButtonsMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterButtonsMock

testAct:
	fcall initialiseButtons

testAssert:
	banksel calledInitialiseAfterButtons
	.assert "calledInitialiseAfterButtons != 0, 'Next initialiser in chain was not called.'"
	return

	end
