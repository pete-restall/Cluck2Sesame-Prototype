	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic16.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_ACCUMULATORTOHOURS
		call loadAccumulatorIntoB
		banksel RBA
		clrf RBA
		movlw 24 << 1
		movwf RBB

multiplyAndGotoNextState:
		fcall mul16x16
		call storeAIntoAccumulator

		banksel sunriseSunsetNextState
		movf sunriseSunsetNextState, W
		movwf sunriseSunsetState
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_ACCUMULATORTOMINUTES
		call loadAccumulatorIntoB
		banksel RBA
		clrf RBA
		movlw 60
		movwf RBB
		goto multiplyAndGotoNextState

	end
