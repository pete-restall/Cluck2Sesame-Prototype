	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"

	radix decimal

SetCursorPositionTest code
	global testAct

testAct:
	fcall setLcdCursorPosition
	return

	end
