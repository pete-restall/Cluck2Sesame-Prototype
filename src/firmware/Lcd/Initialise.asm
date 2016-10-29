	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "States.inc"

	radix decimal

	extern INITIALISE_AFTER_LCD
	extern enableLcdCount

Lcd code
	global initialiseLcd

initialiseLcd:
	banksel enableLcdCount
	clrf enableLcdCount

	setLcdState LCD_STATE_DISABLED
	tcall INITIALISE_AFTER_LCD

	end
