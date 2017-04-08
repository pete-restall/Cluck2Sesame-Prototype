	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "Timer0.inc"
	#include "Lcd.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

HALF_NUMBER_OF_TICKS_20MS_PLUS_MARGIN equ 172

	defineLcdState LCD_STATE_ENABLE_WAITFORMORETHAN40MS
		setLcdWaitState HALF_NUMBER_OF_TICKS_20MS_PLUS_MARGIN, LCD_STATE_ENABLE_WAITFORMORETHAN40MS2
		returnFromLcdState


	defineLcdStateInSameSection LCD_STATE_ENABLE_WAITFORMORETHAN40MS2
		setLcdWaitState HALF_NUMBER_OF_TICKS_20MS_PLUS_MARGIN, LCD_STATE_ENABLE_TRYSETBYTEMODE1
		returnFromLcdState

	end
