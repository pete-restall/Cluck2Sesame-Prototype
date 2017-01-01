	#include "Mcu.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

Cordic code
	global cosine

cosine:
	returnZeroIfNotIdle
	setCordicState CORDIC_STATE_SINECOSINEINITIALISE
	setCordicResultState CORDIC_STATE_STORECOSINERESULT
	retlw 1

	end
