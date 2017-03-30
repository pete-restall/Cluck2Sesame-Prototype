	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Buttons.inc"
	#include "TestFixture.inc"

	radix decimal

ButtonStatesTest code
	global testArrange

testArrange:

testAct:
	fcall initialiseButtons

testAssert:
	banksel button1State
	.assert "button1State == 0, 'Expected button1State to be cleared.'"
	.assert "button2State == 0, 'Expected button2State to be cleared.'"

	return

	end
