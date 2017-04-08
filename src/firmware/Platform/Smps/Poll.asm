	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"

	radix decimal

	extern POLL_AFTER_SMPS

Smps code
	global pollForWork
	global pollSmps

pollForWork:
pollSmps:
	.unknownBank
	tcall POLL_AFTER_SMPS

	end
