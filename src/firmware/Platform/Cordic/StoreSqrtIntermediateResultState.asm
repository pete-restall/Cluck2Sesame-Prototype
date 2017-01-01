	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic16.inc"
	#include "Arithmetic32.inc"
	#include "Cordic.inc"
	#include "States.inc"

	radix decimal

	defineCordicState CORDIC_STATE_STORESQRTINTERMEDIATERESULT
multiplyResultByGainReciprocal:
		call loadCordicXIntoCordicW

		banksel cordicWUpperHigh
		movlw high(HYPERBOLIC_GAIN_RECIPROCAL)
		movwf cordicWUpperHigh
		movlw low(HYPERBOLIC_GAIN_RECIPROCAL)
		movwf cordicWUpperLow

		call loadCordicWIntoB
		fcall mul16x16
		call storeAIntoCordicZ

		setCordicState CORDIC_STATE_STORESQRTINTERMEDIATERESULT2
		returnFromCordicState


	defineCordicStateInSameSection CORDIC_STATE_STORESQRTINTERMEDIATERESULT2
shiftZ15BitsToTheRightIntoLowerWordToConvertToQ16:
		banksel cordicZ
		rlf cordicZLowerHigh, W
		movf cordicZUpperHigh, W
		movwf cordicZLowerHigh
		movf cordicZUpperLow, W
		movwf cordicZLowerLow
		rlf cordicZLowerLow
		rlf cordicZLowerHigh
		clrf cordicZUpperHigh
		clrf cordicZUpperLow

addXToGainAdjustedX:
		call loadCordicXIntoA
		call loadCordicZIntoB
		fcall add32

shiftXOneBitToTheRightToConvertToQ15:
		banksel RAA
		bcf STATUS, C
		rrf RAA
		rrf RAB
		rrf RAC
		rrf RAD
		call storeAIntoCordicX

		setCordicState CORDIC_STATE_ARCTANGENTINITIALISE
		returnFromCordicState

	end
