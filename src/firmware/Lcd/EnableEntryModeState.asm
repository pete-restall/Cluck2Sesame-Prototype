	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

LCD_CMD_ENTRYMODE_MASK equ LCD_CMD_ENTRYMODE | LCD_CMD_ENTRYMODE_INCREMENTING | LCD_CMD_ENTRYMODE_NOSHIFT

	defineLcdState LCD_STATE_ENABLE_ENTRYMODE
	movlw LCD_CMD_ENTRYMODE_MASK
	fcall writeByte

	setLcdState LCD_STATE_ENABLE_SETCONTRAST
	returnFromLcdState

	end
