	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "States.inc"

	radix decimal

	defineLcdState LCD_STATE_ENABLE_DISPLAYON

		movlw LCD_CMD_DISPLAYON
		call writeRegister

		banksel lcdFlags
		bsf lcdFlags, LCD_FLAG_ENABLED

		setLcdState LCD_STATE_IDLE
		returnFromLcdState

	end
