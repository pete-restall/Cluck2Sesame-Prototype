	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"

	radix decimal

DisableBlinkingCursorTest code
	global testAct

testAct:
	fcall disableLcdBlinkingCursor
	return

	end
