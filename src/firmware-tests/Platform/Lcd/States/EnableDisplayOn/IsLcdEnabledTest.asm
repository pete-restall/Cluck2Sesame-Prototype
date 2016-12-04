	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "TestFixture.inc"

	radix decimal

IsLcdEnabledTest code
	global testArrange

testArrange:
	fcall initialiseLcd

testAct:
	setLcdState LCD_STATE_ENABLE_DISPLAYON
	fcall pollLcd
	fcall isLcdEnabled

testAssert:
	.aliasWForAssert _a
	.assert "_a != 0, 'Expected LCD to be enabled.'"
	return

	end
