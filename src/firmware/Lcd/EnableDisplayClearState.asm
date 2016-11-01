	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "States.inc"

	radix decimal

	defineLcdState LCD_STATE_ENABLE_DISPLAYCLEAR
	; TODO: THIS INSTRUCTION TAKES AT LEAST 1.52ms TO COMPLETE...NEED A WAIT STATE.
	returnFromLcdState

	end
