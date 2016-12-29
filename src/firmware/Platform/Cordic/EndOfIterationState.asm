	#include "Mcu.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_ENDOFITERATION
incrementIterationNumber:
		banksel cordicIterationNumber
		incf cordicIterationNumber
		movf cordicIterationNumber, W

checkIfLastIterationOrAnotherIsRequired:
		xorlw NUMBER_OF_ITERATIONS
		btfss STATUS, Z
		goto startNextIteration

storeResult:
		movf cordicResultState, W
		movwf cordicState
		returnFromCordicState

startNextIteration:
		movf cordicStartOfIterationState, W
		movwf cordicState
		returnFromCordicState

	end
