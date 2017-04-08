	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"

	radix decimal

EnableBlinkingCursorTest code
	global testAct

testAct:
	fcall enableLcdBlinkingCursor
	return

	end
