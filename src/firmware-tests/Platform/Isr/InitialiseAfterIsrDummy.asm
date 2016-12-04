	#include "Mcu.inc"
	#include "InitialisationChain.inc"

	radix decimal

InitialiseAfterIsrDummy code
	global INITIALISE_AFTER_ISR

INITIALISE_AFTER_ISR:
	return

	end
