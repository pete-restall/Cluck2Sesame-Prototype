	#include "Mcu.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_ARCTANGENTINITIALISE
		call loadCordicArgumentIntoA
		call storeAIntoCordicY

		banksel cordicIterationNumber
		clrf cordicIterationNumber
		clrf cordicZUpperHigh
		clrf cordicZUpperLow
		clrf cordicZLowerHigh
		clrf cordicZLowerLow

		clrf cordicArgumentHigh
		clrf cordicArgumentLow

		setCordicState CORDIC_STATE_CALCULATEERRORFROMY
		returnFromCordicState

	end
