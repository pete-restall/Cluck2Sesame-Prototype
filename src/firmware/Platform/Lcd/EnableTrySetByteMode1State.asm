	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

NUMBER_OF_TICKS_4_1_MS_PLUS_MARGIN equ 36

	defineLcdState LCD_STATE_ENABLE_TRYSETBYTEMODE1

		movlw b'00000011'
		call writeRegisterNibble

		setLcdWaitState NUMBER_OF_TICKS_4_1_MS_PLUS_MARGIN, LCD_STATE_ENABLE_TRYSETBYTEMODE2
		returnFromLcdState

	end
