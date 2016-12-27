	#define __CLUCK2SESAME_PLATFORM_CORDIC_POLL_ASM

	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"
	#include "TableJumps.inc"
	#include "States.inc"

	radix decimal

	extern POLL_AFTER_CORDIC

	udata
	global cordicState

cordicState res 1

Cordic code
	global pollCordic
	global pollNextInChainAfterCordic

pollCordic:
	tableDefinitionToJumpWith cordicState
	createCordicStateTable

pollNextInChainAfterCordic:
	tcall POLL_AFTER_CORDIC

	end
