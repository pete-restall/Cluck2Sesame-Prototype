	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	extern INITIALISE_AFTER_CORDIC

Cordic code
	global initialiseCordic

initialiseCordic:
	banksel cordicFlags
	clrf cordicFlags

	setCordicState CORDIC_STATE_IDLE
	tcall INITIALISE_AFTER_CORDIC

	end
