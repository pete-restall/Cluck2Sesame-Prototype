	#include "Mcu.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_ITERATION
		banksel cordicNextState
		movf cordicNextState, W
		movwf cordicState
		returnFromCordicState

	end
