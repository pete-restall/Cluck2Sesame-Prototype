	#define __CLUCK2SESAME_PLATFORM_LCD_POLL_ASM

	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "TableJumps.inc"
	#include "PollChain.inc"
	#include "States.inc"

	radix decimal

	extern POLL_AFTER_LCD

Lcd code
	global pollLcd
	global pollNextInChainAfterLcd

pollLcd:
	tableDefinitionToJumpWith lcdState
	createLcdStateTable

pollNextInChainAfterLcd:
	tcall POLL_AFTER_LCD

	end
