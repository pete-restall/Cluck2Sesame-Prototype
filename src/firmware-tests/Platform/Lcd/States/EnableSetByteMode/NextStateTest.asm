	#include "Platform.inc"
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
	setLcdState LCD_STATE_ENABLE_SETBYTEMODE
	fcall pollLcd

testAssert:
	.aliasForAssert lcdState, _a
	.aliasLiteralForAssert LCD_STATE_ENABLE_SETNIBBLEMODE, _b
	.assert "_a == _b, 'Expected state to be LCD_STATE_ENABLE_SETNIBBLEMODE.'"
	return

	end
