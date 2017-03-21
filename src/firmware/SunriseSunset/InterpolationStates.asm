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


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_LATITUDE
loadAbsoluteLatitudeOffsetAsDividend:
		banksel latitudeOffset
		rlf latitudeOffset, W
		movf latitudeOffset, W
		btfsc STATUS, C
		comf latitudeOffset, W
		btfsc STATUS, C
		addlw 1

		banksel RAA
		clrf RAA
		clrf RAB
		movwf RAC
		clrf RAD

loadLookupTableLatitudeDeltaAsDivisor:
		movlw LOOKUP_LATITUDE_DELTA
		clrf RBC
		movwf RBD

		fcall div32x16
		call storeAccumulatorFromA

		banksel accumulator
		clrf accumulatorUpperHigh
		clrf accumulatorUpperLow

		setSunriseSunsetState SUN_STATE_INTERPOLATE_LATITUDE2
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_LATITUDE2
		call loadAccumulatorIntoB
		call loadLookupReferenceDeltaMinutesIntoUpperB
		fcall muls16x16

storeAccumulatorFromAShiftedRight8Bits:
		banksel RAA
		movf RAA, W
		banksel accumulatorUpperLow
		movwf accumulatorUpperLow

		banksel RAB
		movf RAB, W
		banksel accumulatorLowerHigh
		movwf accumulatorLowerHigh

		banksel RAC
		movf RAC, W
		banksel accumulatorLowerLow
		movwf accumulatorLowerLow

		clrf accumulatorUpperHigh
		btfsc accumulatorUpperLow, 7
		comf accumulatorUpperHigh

		setSunriseSunsetState SUN_STATE_INTERPOLATE_LATITUDE3
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_LATITUDE3
		call loadAccumulatorIntoA
		call loadLookupReferenceMinuteIntoB
		fcall add32
		call storeAccumulatorFromA

		setSunriseSunsetState SUN_STATE_INTERPOLATE_LONGITUDE
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_LONGITUDE
loadLongitudeOffsetMultipliedByFourIntoDividend:
		bcf STATUS, C
		banksel longitudeOffset
		rlf longitudeOffset, W
		banksel RAD
		movwf RAD
		btfss STATUS, C
		goto positiveLongitudeOffset

negativeLongitudeOffsetIntoPositive:
		comf RAD
		incf RAD
		bcf STATUS, C

positiveLongitudeOffset:
		rlf RAD
		clrf RAA
		clrf RAB
		clrf RAC

loadTenIntoDivisor:
		clrf RBC
		movlw 10
		movwf RBD

divideAndStoreQuotientAndRemainder:
		fcall div32x16
		call storeLookupIndexFromA

		setSunriseSunsetState SUN_STATE_INTERPOLATE_LONGITUDE2
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_LONGITUDE2
roundUpIfRemainderIsAtLeastFive:
		banksel lookupIndexRemainderLow
		movf lookupIndexRemainderLow, W
		sublw 4
		movf lookupIndexLow, W
		btfss STATUS, C
		incf lookupIndexLow, W

loadOffsetNumberOfMinutesIntoB:
		banksel RBA
		clrf RBA
		clrf RBB
		clrf RBC
		movwf RBD

loadNonOffsetNumberOfMinutesIntoA:
		call loadAccumulatorIntoA
		banksel longitudeOffset

offsetMinutesAreNegativeIfLongitudeOffsetIsPositive:
		btfsc longitudeOffset, 7
		goto adjustNumberOfMinutesInAccumulatorForLongitudeOffset
		fcall negateB32

adjustNumberOfMinutesInAccumulatorForLongitudeOffset:
		fcall add32
		call storeAccumulatorFromA

		setSunriseSunsetState SUN_STATE_ACCUMULATORTOHOURS
		returnFromSunriseSunsetState

	end
