	#include "Mcu.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_STORESINERESULT
		call loadCordicYIntoA
		call storeSaturatedAIntoCordicResultQ15

		setCordicState CORDIC_STATE_IDLE
		returnFromCordicState


	defineCordicStateInSameSection CORDIC_STATE_STORECOSINERESULT
		call loadCordicXIntoA
		call storeSaturatedAIntoCordicResultQ15

		setCordicState CORDIC_STATE_IDLE
		returnFromCordicState

	end
