	#ifndef __CLUCK2SESAME_LCD_WAITSTATE_INC
	#define __CLUCK2SESAME_LCD_WAITSTATE_INC
	#include "States.inc"
	#include "Timer0.inc"

	radix decimal

	#define LCD_WAIT_PARAM_INITIAL_TICKS lcdStateParameter0
	#define LCD_WAIT_PARAM_NUMBER_OF_TICKS lcdStateParameter1

setLcdWaitState macro numberOfTicks, nextState
	storeTimer0 LCD_WAIT_PARAM_INITIAL_TICKS
	movlw numberOfTicks
	movwf LCD_WAIT_PARAM_NUMBER_OF_TICKS

	setLcdNextState nextState
	setLcdState LCD_STATE_WAIT
	endm

	#endif
