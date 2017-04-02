	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	udata

Lcd code
	global enableLcdBlinkingCursor
	global disableLcdBlinkingCursor

enableLcdBlinkingCursor:
	bsf STATUS, C

returnIfNotIdle:
	banksel lcdState
	movlw LCD_STATE_IDLE
	xorwf lcdState, W
	btfss STATUS, Z
	retlw 0

writeDisplayOnCommandWithCarryBitInTwoLsbs:
	movlw LCD_STATE_WRITE_REGISTER
	movwf lcdState
	movlw LCD_STATE_IDLE
	movwf lcdNextState
	movlw LCD_CMD_DISPLAYON >> 2
	movwf lcdStateParameter0
	rlf lcdStateParameter0
	rrf lcdStateParameter0, W
	rlf lcdStateParameter0
	retlw 1

disableLcdBlinkingCursor:
	bcf STATUS, C
	goto returnIfNotIdle

	end
