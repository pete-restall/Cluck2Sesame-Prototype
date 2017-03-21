	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"

	radix decimal

	extern INITIALISE_AFTER_DOOR

Door code
	global initialiseDoor

initialiseDoor:
	tcall INITIALISE_AFTER_DOOR

	end
