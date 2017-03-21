	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"

	radix decimal

	extern POLL_AFTER_DOOR

Door code
	global pollDoor

pollDoor:
	tcall POLL_AFTER_DOOR

	end
