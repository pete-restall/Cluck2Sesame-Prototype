	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineLcdState LCD_STATE_ENABLE_SETNIBBLEMODE
	movlw b'00000010'
	fcall writeNibble

	setLcdState LCD_STATE_ENABLE_SETDISPLAY
	returnFromLcdState

	end
