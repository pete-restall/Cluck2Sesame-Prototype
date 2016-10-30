	#define __CLUCK2SESAME_LCD_INITIALISE_ASM

	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "States.inc"

	radix decimal

	extern INITIALISE_AFTER_LCD
	extern enableLcdCount

	udata
	global lcdFlags

lcdFlags res 1

Lcd code
	global initialiseLcd

initialiseLcd:
	banksel enableLcdCount
	clrf enableLcdCount

	; TODO: CLEAR lcdFlags...

	setLcdState LCD_STATE_DISABLED
	tcall INITIALISE_AFTER_LCD

	end
