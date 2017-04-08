	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_INTERPOLATE_LATITUDE
loadAbsoluteLatitudeOffsetAsDividend:
		.setBankFor latitudeOffset
		rlf latitudeOffset, W
		movf latitudeOffset, W
		btfsc STATUS, C
		comf latitudeOffset, W
		btfsc STATUS, C
		addlw 1

		.setBankFor RAA
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

		.setBankFor accumulator
		clrf accumulatorUpperHigh
		clrf accumulatorUpperLow

		setSunriseSunsetState SUN_STATE_INTERPOLATE_LATITUDE2
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_INTERPOLATE_LATITUDE2
		call loadAccumulatorIntoB
		call loadLookupReferenceDeltaMinutesIntoUpperB
		fcall muls16x16

storeAccumulatorFromAShiftedRight8Bits:
		.setBankFor RAA
		movf RAA, W
		.setBankFor accumulatorUpperLow
		movwf accumulatorUpperLow

		.setBankFor RAB
		movf RAB, W
		.setBankFor accumulatorLowerHigh
		movwf accumulatorLowerHigh

		.setBankFor RAC
		movf RAC, W
		.setBankFor accumulatorLowerLow
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

	end
