	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

Lcd code
	global putCharacter
	global putBcdDigit
	global putBcdDigits

putCharacter:
	goto writeCharacterFromWWithIdleNextState

putBcdDigit:
	; TODO: THIS FUNCTION NEEDS WRITING

putBcdDigits:
	; TODO: THIS FUNCTION NEEDS WRITING
	return

	end
