	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"

	radix decimal

PutBcdDigitsTest code
	global testAct

testAct:
	fcall putBcdDigits
	return

	end
