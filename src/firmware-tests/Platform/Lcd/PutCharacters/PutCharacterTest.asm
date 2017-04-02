	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"

	radix decimal

PutCharacterTest code
	global testAct

testAct:
	fcall putCharacter
	return

	end
