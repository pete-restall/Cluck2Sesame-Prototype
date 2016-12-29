	#include "Mcu.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

Cordic code
	global cosine

cosine:
	; TODO: If cordicState != CORDIC_STATE_IDLE then retlw 0, else do the
	; sine magic and retlw 1

	setCordicState CORDIC_STATE_SINECOSINEINITIALISE
	setCordicResultState CORDIC_STATE_STORECOSINERESULT
	return

	end
