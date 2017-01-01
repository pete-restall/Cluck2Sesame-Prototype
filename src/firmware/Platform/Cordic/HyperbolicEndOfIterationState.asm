	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_HYPERBOLIC_ENDOFITERATION
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

incrementIterationNumber:
		movf cordicIterationNumber, W
		incf cordicIterationNumber

checkIfLastIterationOrAnotherIsRequired:
		xorlw NUMBER_OF_ITERATIONS
		btfss STATUS, Z
		goto startNextIteration

storeResult:
		setCordicState CORDIC_STATE_STORESQRTINTERMEDIATERESULT
		returnFromCordicState

repeatIteration:
		movlw 1 << CORDIC_FLAG_REPEATITERATION
		xorwf cordicFlags
		btfss cordicFlags, CORDIC_FLAG_REPEATITERATION
		goto incrementIterationNumber

startNextIteration:
		setCordicState CORDIC_STATE_HYPERBOLIC_CALCULATEX_SHIFT
		returnFromCordicState

	end
