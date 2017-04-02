	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	extern isLcdIdle

	udata

Lcd code
	global putCharacter
	global putBcdDigit
	global putBcdDigits

putCharacter:
	goto writeCharacterFromWWithIdleNextState

putBcdDigit:
putBcdDigits:
	return

	end
