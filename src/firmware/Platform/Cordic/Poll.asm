	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"

	radix decimal

	extern POLL_AFTER_CORDIC

Cordic code
	global pollCordic

pollCordic:
	tcall POLL_AFTER_CORDIC

	end
