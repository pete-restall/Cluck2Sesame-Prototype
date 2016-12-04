	#define __CLUCK2SESAME_PLATFORM_LCD_INITIALISE_ASM

	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	extern INITIALISE_AFTER_LCD
	extern enableLcdCount
	extern lcdContrast

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

	banksel lcdContrast
	movlw DEFAULT_LCD_CONTRAST
	movwf lcdContrast

	banksel lcdFlags
	clrf lcdFlags

	banksel LCD_CONTRAST_ANSEL
	bcf LCD_CONTRAST_ANSEL, LCD_CONTRAST_PIN_ANSEL

	banksel LCD_CONTRAST_TRIS
	bcf LCD_CONTRAST_TRIS, LCD_CONTRAST_PIN_TRIS

	banksel LCD_CONTRAST_PORT
	bcf LCD_CONTRAST_PORT, LCD_CONTRAST_PIN

	setLcdState LCD_STATE_DISABLED
	tcall INITIALISE_AFTER_LCD

	end
