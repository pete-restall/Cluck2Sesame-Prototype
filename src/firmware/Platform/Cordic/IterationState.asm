	#include "Mcu.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_ITERATION
		banksel cordicResultState
		movf cordicResultState, W
		movwf cordicState
		returnFromCordicState

	end
