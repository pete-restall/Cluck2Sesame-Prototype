	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineLcdState LCD_STATE_ENABLE_DISPLAYOFF
	movlw LCD_CMD_DISPLAYOFF
	fcall writeByte

	setLcdState LCD_STATE_ENABLE_DISPLAYCLEAR
	returnFromLcdState

	end
