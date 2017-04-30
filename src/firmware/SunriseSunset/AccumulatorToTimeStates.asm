	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_ACCUMULATORTOHOURS
		setSunriseSunsetState SUN_STATE_ACCUMULATORTOHOURS2

adjustAccumulatorBySpecifiedNumberOfMinutes:
		.setBankFor adjustmentMinutes
		movf adjustmentMinutes, W
		call loadWIntoB
		call loadAccumulatorIntoA
		fcall add32
		call storeAccumulatorFromA
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_ACCUMULATORTOHOURS2
		.setBankFor RBC
		clrf RBC
		movlw 60
		movwf RBD

		call loadAccumulatorIntoA

divideAndStoreResultAndRemainderInAccumulator:
		fcall div32x16
		call storeAccumulatorFromA

		.setBankFor sunriseSunsetStoreState
		movf sunriseSunsetStoreState, W
		movwf sunriseSunsetState
		returnFromSunriseSunsetState

	end
