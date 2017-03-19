	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_ACCUMULATORTOHOURS
		call loadAccumulatorIntoA
		banksel RBC
		clrf RBC
		movlw 60
		movwf RBD

divideAndStoreResultAndRemainder:
		fcall div32x16
		call storeAccumulatorFromA

		banksel sunriseSunsetStoreState
		movf sunriseSunsetStoreState, W
		movwf sunriseSunsetState
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_ACCUMULATORTOMINUTES
; TODO: NOT NECESSARY ANYMORE !
		call loadAccumulatorIntoB
		banksel RBA
		clrf RBA
		movlw 60
		movwf RBB
		goto divideAndStoreResultAndRemainder

	end
