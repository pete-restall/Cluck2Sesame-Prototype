	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../LcdStates.inc"
	#include "TestFixture.inc"

	radix decimal

StateAfterEnabledFirstTimeTest code
	global testArrange

testArrange:
	fcall initialiseLcd

testAct:
	fcall enableLcd

testAssert:
	.assertStateIs LCD_STATE_ENABLE_WAITFORSHIFTREGISTER
	return

	end
