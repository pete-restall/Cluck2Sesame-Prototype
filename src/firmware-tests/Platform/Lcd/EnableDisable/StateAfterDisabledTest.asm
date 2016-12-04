	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../LcdStates.inc"
	#include "TestFixture.inc"

	radix decimal

StateAfterDisabledTest code
	global testArrange

testArrange:
	fcall initialiseLcd
	fcall enableLcd

testAct:
	fcall disableLcd

testAssert:
	.assertStateIs LCD_STATE_DISABLED
	return

	end
