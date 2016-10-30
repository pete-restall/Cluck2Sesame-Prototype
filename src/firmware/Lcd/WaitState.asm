	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "Timer0.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

	defineLcdState LCD_STATE_WAIT
	elapsedSinceTimer0 LCD_WAIT_PARAM_INITIAL_TICKS
	banksel LCD_WAIT_PARAM_NUMBER_OF_TICKS
	subwf LCD_WAIT_PARAM_NUMBER_OF_TICKS, W

	btfss STATUS, C
	goto greaterThanOrEqualToTicks

	btfss STATUS, Z
	goto endOfState

greaterThanOrEqualToTicks:
	movf lcdNextState, W
	movwf lcdState

endOfState:
	returnFromLcdState

	end
