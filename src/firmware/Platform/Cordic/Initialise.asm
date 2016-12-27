	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"

	radix decimal

	extern INITIALISE_AFTER_CORDIC

Cordic code
	global initialiseCordic

initialiseCordic:
	tcall INITIALISE_AFTER_CORDIC

	end
