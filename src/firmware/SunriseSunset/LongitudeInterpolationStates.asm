	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_INTERPOLATE_LONGITUDE
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