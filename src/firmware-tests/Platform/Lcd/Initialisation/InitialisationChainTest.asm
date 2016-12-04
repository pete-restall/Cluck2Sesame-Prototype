	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "TestFixture.inc"
	#include "../InitialiseAfterLcdMock.inc"

	radix decimal

InitialisationChainTest code
	global testArrange

testArrange:
	fcall initialiseInitialiseAfterLcdMock

testAct:
	fcall initialiseLcd

testAssert:
	banksel calledInitialiseAfterLcd
	.assert "calledInitialiseAfterLcd != 0, 'Next initialiser in chain was not called.'"
	return

	end
