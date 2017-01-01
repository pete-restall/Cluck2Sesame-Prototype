	#include "Mcu.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

Cordic code
	global arcSine

arcSine:
	returnZeroIfNotIdle
	setCordicState CORDIC_STATE_ARCSINEINITIALISE
	setCordicResultState CORDIC_STATE_STOREARCSINERESULT
	retlw 1

	end
