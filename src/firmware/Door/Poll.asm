	#define __CLUCK2SESAME_DOOR_POLL_ASM

	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "TableJumps.inc"
	#include "PollChain.inc"
	#include "States.inc"

	radix decimal

	extern POLL_AFTER_DOOR

Door code
	global pollDoor
	global pollNextInChainAfterDoor

pollDoor:
	.unknownBank
	tableDefinitionToJumpWith doorState
	createDoorStateTable

pollNextInChainAfterDoor:
	tcall POLL_AFTER_DOOR

	end
