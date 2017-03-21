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

divideAndStoreResultAndRemainderInAccumulator:
		fcall div32x16
		call storeAccumulatorFromA

		banksel sunriseSunsetStoreState
		movf sunriseSunsetStoreState, W
		movwf sunriseSunsetState
		returnFromSunriseSunsetState

	end