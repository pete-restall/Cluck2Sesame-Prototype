	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_CALCULATEY_SHIFT
		call shiftCordicWByIterationNumber
		setCordicState CORDIC_STATE_CALCULATEY_ADD
		returnFromCordicState


	defineCordicStateInSameSection CORDIC_STATE_CALCULATEY_ADD
		call loadCordicYIntoA
		call loadCordicWIntoB

		banksel cordicFlags
		btfsc cordicFlags, CORDIC_FLAG_ERRORPOSITIVE
		goto addAccumulatorsAndStore
		fcall negateB32

addAccumulatorsAndStore:
		fcall add32
		call storeAIntoCordicY

		setCordicState CORDIC_STATE_CALCULATEZ
		returnFromCordicState

	end
