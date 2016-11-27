	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"

	radix decimal

	extern POLL_AFTER_UI

Ui code
	global pollUi

pollUi:
	tcall POLL_AFTER_UI

	end
