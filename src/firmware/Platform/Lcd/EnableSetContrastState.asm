	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "../Adc.inc"
	#include "States.inc"

	radix decimal

	defineLcdState LCD_STATE_ENABLE_SETCONTRAST
		setLcdState LCD_STATE_ENABLE_DISPLAYON
		fcall enableAdc
		returnFromLcdState

	end
