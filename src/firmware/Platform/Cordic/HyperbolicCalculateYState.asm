	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_HYPERBOLIC_CALCULATEY_SHIFT
		call shiftCordicWByIterationNumber
		setCordicState CORDIC_STATE_HYPERBOLIC_CALCULATEY_ADD
		returnFromCordicState


	defineCordicStateInSameSection CORDIC_STATE_HYPERBOLIC_CALCULATEY_ADD
		call loadCordicYIntoA
		call loadCordicWIntoB

checkIfYIsNotNegative:
		banksel cordicYUpperHigh
		btfsc cordicYUpperHigh, 7
		goto addAccumulatorsAndStore
		fcall negateB32

addAccumulatorsAndStore:
		fcall add32
		call storeAIntoCordicY

		setCordicState CORDIC_STATE_HYPERBOLIC_ENDOFITERATION
		returnFromCordicState

checkIfIterationRepetitionIsNecessaryForConvergence:
		banksel cordicIterationNumber
		movlw 4
		xorwf cordicIterationNumber, W
		btfsc STATUS, Z
		goto repeatIteration

		movlw 13
		xorwf cordicIterationNumber, W
		btfsc STATUS, Z
		goto repeatIteration

nextIteration:
		setCordicState CORDIC_STATE_HYPERBOLIC_ENDOFITERATION
		returnFromCordicState

repeatIteration:
		movlw 1 << CORDIC_FLAG_REPEATITERATION
		xorwf cordicFlags
		btfss cordicFlags, CORDIC_FLAG_REPEATITERATION
		goto nextIteration

		setCordicState CORDIC_STATE_HYPERBOLIC_CALCULATEX_SHIFT
		returnFromCordicState

	end
