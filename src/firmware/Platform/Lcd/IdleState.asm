	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "States.inc"

	radix decimal

	global isLcdIdle

	defineLcdState LCD_STATE_IDLE
	returnFromLcdState

isLcdIdle:
	.safelySetBankFor lcdState
	movf lcdState, W
	xorlw LCD_STATE_IDLE
	btfss STATUS, Z
	retlw 0
	retlw 1

	end
