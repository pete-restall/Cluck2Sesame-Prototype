	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"

	radix decimal

	extern POLL_AFTER_DOOR

Door code
	global pollDoor

pollDoor:
	.unknownBank
	tcall POLL_AFTER_DOOR

	end
