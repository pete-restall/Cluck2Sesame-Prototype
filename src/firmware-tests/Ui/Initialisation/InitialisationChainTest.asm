	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Ui.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterUiMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterUiMock

testAct:
	fcall initialiseUi

testAssert:
	banksel calledInitialiseAfterUi
	.assert "calledInitialiseAfterUi != 0, 'Next initialiser in chain was not called.'"
	return

	end
