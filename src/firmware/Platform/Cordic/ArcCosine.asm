	#include "Mcu.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

Cordic code
	global arcCosine

arcCosine:
	returnZeroIfNotIdle
	setCordicState CORDIC_STATE_ARCSINEINITIALISE
	setCordicResultState CORDIC_STATE_STOREARCCOSINERESULT
	retlw 1

	end
