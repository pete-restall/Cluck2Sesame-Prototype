	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"

	radix decimal

	extern POLL_AFTER_SMPS

Smps code
	global pollForWork
	global pollSmps

pollForWork:
pollSmps:
	tcall POLL_AFTER_SMPS

	end
