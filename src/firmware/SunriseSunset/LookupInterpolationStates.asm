	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_INTERPOLATE_REFERENCE
		call loadFirstLookupReferenceMinuteIntoB
		fcall negateB32
		call loadSecondLookupReferenceMinuteIntoA
		fcall add32
		call storeAccumulatorFromA

		setSunriseSunsetNextState SUN_STATE_INTERPOLATE_REFERENCE2
		setSunriseSunsetState SUN_STATE_INTERPOLATE_LOOKUP
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_LOOKUP
		call loadAccumulatorIntoB
		call loadLookupIndexRemainderIntoUpperB
		call muls16x16
		call storeAccumulatorFromA

		setSunriseSunsetState SUN_STATE_INTERPOLATE_LOOKUP2
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_LOOKUP2
		call loadAccumulatorIntoA
		banksel RAA
		btfss RAA, 7
		goto loadDivisorIntoAccumulatorBAndDivide

preventOverflowFromNegativeDividend:
		fcall negateA32

loadDivisorIntoAccumulatorBAndDivide:
		call loadLookupStepIntoLowerB
		fcall div32x16

		banksel accumulatorUpperHigh
		btfsc accumulatorUpperHigh, 7
		goto storeNegativeAccumulatorFromA

storePositiveAccumulatorFromA:
		call storeAccumulatorFromA
		banksel accumulatorUpperHigh
		clrf accumulatorUpperHigh
		clrf accumulatorUpperLow
		goto nextState

storeNegativeAccumulatorFromA:
		fcall negateA32
		call storeAccumulatorFromA

nextState:
		banksel sunriseSunsetNextState
		movf sunriseSunsetNextState, W
		movwf sunriseSunsetState
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_REFERENCE2
		call loadAccumulatorIntoA
		call loadFirstLookupReferenceMinuteIntoB
		fcall add32

storeAccumulatorIntoLookupReferenceMinute:
		banksel RAC
		movf RAC, W
		banksel lookupReferenceMinuteHigh
		movwf lookupReferenceMinuteHigh
		banksel RAD
		movf RAD, W
		banksel lookupReferenceMinuteLow
		movwf lookupReferenceMinuteLow

nextStateDependsOnLatitudeAboveOrBelowReference:
		btfsc latitudeOffset, 7
		goto nextStateIsSouthInterpolation

nextStateIsNorthInterpolation:
		setSunriseSunsetState SUN_STATE_INTERPOLATE_NORTHDELTA
		returnFromSunriseSunsetState

nextStateIsSouthInterpolation:
		setSunriseSunsetState SUN_STATE_INTERPOLATE_SOUTHDELTA
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_NORTHDELTA
		call loadFirstLookupDeltaMinutesNorthIntoB
		fcall negateB32
		call loadSecondLookupDeltaMinutesNorthIntoA
		fcall add32
		call storeAccumulatorFromA

		setSunriseSunsetNextState SUN_STATE_INTERPOLATE_NORTHDELTA2
		setSunriseSunsetState SUN_STATE_INTERPOLATE_LOOKUP
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_NORTHDELTA2
		call loadAccumulatorIntoA
		call loadFirstLookupDeltaMinutesNorthIntoB
		fcall add32
		call storeLookupReferenceDeltaMinutesFromA

		setSunriseSunsetState SUN_STATE_INTERPOLATE_LATITUDE
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_SOUTHDELTA
		call loadFirstLookupDeltaMinutesSouthIntoB
		fcall negateB32
		call loadSecondLookupDeltaMinutesSouthIntoA
		fcall add32
		call storeAccumulatorFromA

		setSunriseSunsetNextState SUN_STATE_INTERPOLATE_SOUTHDELTA2
		setSunriseSunsetState SUN_STATE_INTERPOLATE_LOOKUP
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_SOUTHDELTA2
		call loadAccumulatorIntoA
		call loadFirstLookupDeltaMinutesSouthIntoB
		fcall add32
		call storeLookupReferenceDeltaMinutesFromA

		setSunriseSunsetState SUN_STATE_INTERPOLATE_LATITUDE
		returnFromSunriseSunsetState

	end
