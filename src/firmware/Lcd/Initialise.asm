	#define __CLUCK2SESAME_LCD_INITIALISE_ASM

	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	extern INITIALISE_AFTER_LCD
	extern enableLcdCount

	udata
	global lcdFlags
	global lcdWorkingRegister

lcdFlags res 1
lcdWorkingRegister res 1

Lcd code
	global initialiseLcd

initialiseLcd:
	banksel enableLcdCount
	clrf enableLcdCount

	; TODO: CLEAR lcdFlags...

	banksel LCD_CONTRAST_ANSEL
	bcf LCD_CONTRAST_ANSEL, LCD_CONTRAST_PIN_ANSEL

	banksel LCD_CONTRAST_TRIS
	bcf LCD_CONTRAST_TRIS, LCD_CONTRAST_PIN_TRIS

	banksel LCD_CONTRAST_PORT
	bcf LCD_CONTRAST_PORT, LCD_CONTRAST_PIN

	setLcdState LCD_STATE_DISABLED
	tcall INITIALISE_AFTER_LCD

	end
