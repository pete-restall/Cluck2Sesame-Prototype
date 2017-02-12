	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNRISE_STOREHOUR
		banksel accumulator
		movf accumulatorUpperLow, W
		movwf sunriseHourBcd

		setSunriseSunsetNextState SUN_STATE_SUNRISE_STOREMINUTE
		setSunriseSunsetState SUN_STATE_ACCUMULATORTOMINUTES
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_SUNRISE_STOREMINUTE
		banksel accumulator
		movf accumulatorUpperLow, W
		movwf sunriseMinuteBcd
		btfsc accumulatorLowerHigh, 7
		incf sunriseMinuteBcd

		; TODO: WHEN ROUNDING UP, NEED TO INCREMENT HOUR IF MINUTE == 59 AND
		; ROUNDED TO 00
		setSunriseSunsetState SUN_STATE_SUNRISE_STOREASBCD
		returnFromSunriseSunsetState

	defineSunriseSunsetStateInSameSection SUN_STATE_SUNRISE_STOREASBCD
		banksel sunriseMinuteBcd
		movf sunriseMinuteBcd, W
		banksel RAA
		movwf RAA
		fcall binaryToBcd
		banksel sunriseMinuteBcd
		movwf sunriseMinuteBcd

		setSunriseSunsetState SUN_STATE_SUNSET_STOREMINUTE
		returnFromSunriseSunsetState

	end
