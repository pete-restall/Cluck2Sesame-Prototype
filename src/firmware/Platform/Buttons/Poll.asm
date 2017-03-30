	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"

	radix decimal

	extern POLL_AFTER_BUTTONS

Buttons code
	global pollButtons

pollButtons:
	tcall POLL_AFTER_BUTTONS

	end
