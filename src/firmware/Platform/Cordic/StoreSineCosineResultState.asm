	#include "Mcu.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_STORESINERESULT
		banksel cordicResult
		movlw 0xff
		movwf cordicResultHigh
		movwf cordicResultLow

		setCordicState CORDIC_STATE_IDLE
		returnFromCordicState


	defineCordicStateInSameSection CORDIC_STATE_STORECOSINERESULT
		returnFromCordicState

	end
