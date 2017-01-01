	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

ONE_QUARTER_Q0_16 equ 0x4000

	defineCordicState CORDIC_STATE_SQRTINITIALISE
		banksel cordicIterationNumber
		movlw 1
		movwf cordicIterationNumber

addOneQuarterToWAndStoreInX:
		call loadOneQuarterIntoA
		call loadCordicWIntoB
		fcall add32
		call storeAIntoCordicX

		setCordicState CORDIC_STATE_SQRTINITIALISE2
		returnFromCordicState


	defineCordicStateInSameSection CORDIC_STATE_SQRTINITIALISE2
subtractOneQuarterFromWAndStoreInY:
		call loadOneQuarterIntoA
		fcall negateA32
		call loadCordicWIntoB
		fcall add32
		call storeAIntoCordicY

		setCordicState CORDIC_STATE_HYPERBOLIC_CALCULATEX_SHIFT
		returnFromCordicState

loadOneQuarterIntoA:
	banksel RAA
	clrf RAA
	clrf RAB
	movlw high(ONE_QUARTER_Q0_16)
	movwf RAC
	movlw low(ONE_QUARTER_Q0_16)
	movwf RAD
	return

	end
