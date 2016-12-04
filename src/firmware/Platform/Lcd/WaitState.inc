	#ifndef __CLUCK2SESAME_PLATFORM_LCD_WAITSTATE_INC
	#define __CLUCK2SESAME_PLATFORM_LCD_WAITSTATE_INC
	#include "States.inc"
	#include "Timer0.inc"

	radix decimal

	#define LCD_WAIT_PARAM_INITIAL_TICKS lcdStateParameter0
	#define LCD_WAIT_PARAM_NUMBER_OF_TICKS lcdStateParameter1

setLcdWaitStateWithUnmodifiedNextState macro numberOfTicks
	storeTimer0 LCD_WAIT_PARAM_INITIAL_TICKS
	movlw numberOfTicks
	movwf LCD_WAIT_PARAM_NUMBER_OF_TICKS

	setLcdState LCD_STATE_WAIT
	endm

setLcdWaitState macro numberOfTicks, nextState
	setLcdWaitStateWithUnmodifiedNextState numberOfTicks
	setLcdNextState nextState
	endm

	#endif
