	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"

LCD_CMD_SETDISPLAY_MASK equ LCD_CMD_SETDISPLAY | LCD_CMD_SETDISPLAY_TWOLINES | LCD_CMD_SETDISPLAY_5X8

	radix decimal

	defineLcdState LCD_STATE_ENABLE_SETDISPLAY
	movlw LCD_CMD_SETDISPLAY_MASK
	fcall writeByte

	setLcdState LCD_STATE_ENABLE_DISPLAYOFF
	returnFromLcdState

	end
