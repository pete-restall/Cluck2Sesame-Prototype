	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_CALCULATEERRORFROMZ
		setCordicStartOfIterationState CORDIC_STATE_CALCULATEERRORFROMZ
		call loadCordicZIntoB
		goto calculateCordicError


	defineCordicStateInSameSection CORDIC_STATE_CALCULATEERRORFROMY
		; TODO: THIS WILL NEED WRITING FOR THE ARC CALCULATIONS
		; setCordicStartOfIterationState CORDIC_STATE_CALCULATEERRORFROMY
		; call loadCordicYIntoB

calculateCordicError:
		banksel cordicFlags
		bcf cordicFlags, CORDIC_FLAG_ERRORPOSITIVE

subtractAccumulatorBFromA:
		call loadCordicArgumentIntoA
		fcall negateB32
		fcall add32

testSignOfError:
		btfsc STATUS, Z
		goto errorIsZero
		banksel RAA
		btfsc RAA, 7
		goto errorIsNegative

errorIsPositive:
		banksel cordicFlags
		bsf cordicFlags, CORDIC_FLAG_ERRORPOSITIVE

errorIsZero:
errorIsNegative:
		setCordicState CORDIC_STATE_CALCULATEX_SHIFT
		returnFromCordicState

	end
