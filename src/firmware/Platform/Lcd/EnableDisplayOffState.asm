	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineLcdState LCD_STATE_ENABLE_DISPLAYOFF

		movlw LCD_CMD_DISPLAYOFF
		call writeRegister

		setLcdState LCD_STATE_DISPLAYCLEAR
		setLcdNextState LCD_STATE_ENABLE_ENTRYMODE
		returnFromLcdState

	end
