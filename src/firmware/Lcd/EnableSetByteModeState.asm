	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineLcdState LCD_STATE_ENABLE_SETBYTEMODE

		movlw b'00000011'
		call writeRegisterNibble

		setLcdState LCD_STATE_ENABLE_SETNIBBLEMODE
		returnFromLcdState

	end
