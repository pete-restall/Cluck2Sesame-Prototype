	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_STOREARCSINERESULT
		call loadCordicZIntoA
		fcall negateA32
		call storeSaturatedAIntoCordicResultQ15

		setCordicState CORDIC_STATE_IDLE
		returnFromCordicState

	end
