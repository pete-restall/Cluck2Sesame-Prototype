	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../LcdStates.inc"
	#include "TestFixture.inc"

	radix decimal

NextStateTest code
	global testArrange

testArrange:
	fcall initialiseLcd

testAct:
	setLcdState LCD_STATE_WRITE_REGISTER
	fcall pollLcd

testAssert:
	.aliasForAssert lcdState, _a
	.aliasForAssert lcdNextState, _b
	.assert "_a == _b, 'Expected lcdState == lcdNextState.'"
	return

	end
