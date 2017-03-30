	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"

	radix decimal

	extern INITIALISE_AFTER_BUTTONS

Buttons code
	global initialiseButtons

initialiseButtons:
	tcall INITIALISE_AFTER_BUTTONS

	end
