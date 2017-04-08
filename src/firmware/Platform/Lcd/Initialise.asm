	#define __CLUCK2SESAME_PLATFORM_LCD_INITIALISE_ASM

	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	extern INITIALISE_AFTER_LCD

Lcd code
	global initialiseLcd

initialiseLcd:
	.safelySetBankFor enableLcdCount
	clrf enableLcdCount

	movlw DEFAULT_LCD_CONTRAST
	movwf lcdContrast

	clrf lcdFlags

	.setBankFor LCD_CONTRAST_ANSEL
	bcf LCD_CONTRAST_ANSEL, LCD_CONTRAST_PIN_ANSEL

	.setBankFor LCD_CONTRAST_TRIS
	bcf LCD_CONTRAST_TRIS, LCD_CONTRAST_PIN_TRIS

	.setBankFor LCD_CONTRAST_PORT
	bcf LCD_CONTRAST_PORT, LCD_CONTRAST_PIN

	setLcdState LCD_STATE_DISABLED
	tcall INITIALISE_AFTER_LCD

	end
