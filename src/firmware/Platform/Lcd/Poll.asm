	#define __CLUCK2SESAME_PLATFORM_LCD_POLL_ASM

	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "TableJumps.inc"
	#include "PollChain.inc"
	#include "States.inc"

	radix decimal

	extern POLL_AFTER_LCD

	udata
	global lcdState
	global lcdStateParameter0
	global lcdStateParameter1
	global lcdNextState

lcdState res 1
lcdStateParameter0 res 1
lcdStateParameter1 res 1
lcdNextState res 1

Lcd code
	global pollLcd
	global pollNextInChainAfterLcd

pollLcd:
	tableDefinitionToJumpWith lcdState
	createLcdStateTable

pollNextInChainAfterLcd:
	tcall POLL_AFTER_LCD

	end
