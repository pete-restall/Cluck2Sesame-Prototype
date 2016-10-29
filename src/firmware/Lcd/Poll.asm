	#define __CLUCK2SESAME_LCD_POLL_ASM

	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"
	#include "States.inc"

	radix decimal

	extern POLL_AFTER_LCD

	udata
	global lcdState

lcdState res 1

Lcd code
	global pollLcd
	global pollNextInChainAfterLcd

pollLcd:
	goto lcdState1
	createLcdStateTable

pollNextInChainAfterLcd:
	tcall POLL_AFTER_LCD

	end
