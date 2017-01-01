	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_HYPERBOLIC_CALCULATEX_SHIFT
		call loadCordicYIntoCordicW
		call shiftCordicWByIterationNumber
		setCordicState CORDIC_STATE_HYPERBOLIC_CALCULATEX_ADD
		returnFromCordicState


	defineCordicStateInSameSection CORDIC_STATE_HYPERBOLIC_CALCULATEX_ADD
		call loadCordicXIntoA
		call loadCordicWIntoB
		call loadCordicXIntoCordicW

checkIfYIsNotNegative:
		banksel cordicYUpperHigh
		btfsc cordicYUpperHigh, 7
		goto addAccumulatorsAndStore
		fcall negateB32

addAccumulatorsAndStore:
		fcall add32
		call storeAIntoCordicX

		setCordicState CORDIC_STATE_HYPERBOLIC_CALCULATEY_SHIFT
		returnFromCordicState

	end
