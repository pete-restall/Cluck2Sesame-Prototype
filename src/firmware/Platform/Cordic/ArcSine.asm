	#include "Mcu.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

Cordic code
	global arcSine

arcSine:
	; TODO: If cordicState != CORDIC_STATE_IDLE then retlw 0, else do the
	; sine magic and retlw 1

	setCordicState CORDIC_STATE_ARCSINEINITIALISE
	setCordicResultState CORDIC_STATE_STOREARCSINERESULT
	return

	end
