	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

NUMBER_OF_TICKS_1_52_MS_PLUS_MARGIN equ 13

	defineLcdState LCD_STATE_DISPLAYCLEAR

		movlw LCD_CMD_DISPLAYCLEAR
		call writeRegister

		setLcdWaitStateWithUnmodifiedNextState NUMBER_OF_TICKS_1_52_MS_PLUS_MARGIN
		returnFromLcdState

	end
