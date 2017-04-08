	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

NUMBER_OF_TICKS_100US_PLUS_MARGIN equ 1

	defineLcdState LCD_STATE_ENABLE_TRYSETBYTEMODE2
		movlw b'00000011'
		call writeRegisterNibble

		setLcdWaitState NUMBER_OF_TICKS_100US_PLUS_MARGIN, LCD_STATE_ENABLE_SETBYTEMODE
		returnFromLcdState

	end
