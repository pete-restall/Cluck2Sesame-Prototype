	#include "Mcu.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

Cordic code
	global sine

sine:
	returnZeroIfNotIdle
	setCordicState CORDIC_STATE_SINECOSINEINITIALISE
	setCordicResultState CORDIC_STATE_STORESINERESULT
	retlw 1

	end
