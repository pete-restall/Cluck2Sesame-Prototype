	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNRISE_STOREHOUR
		banksel accumulatorLowerLow
		movf accumulatorLowerLow, W
		banksel sunriseHourBcd
		movwf sunriseHourBcd

		banksel accumulatorUpperLow
		movf accumulatorUpperLow, W
		banksel sunriseMinuteBcd
		movwf sunriseMinuteBcd

		;setSunriseSunsetNextState SUN_STATE_SUNRISE_STOREMINUTE
		;setSunriseSunsetState SUN_STATE_ACCUMULATORTOMINUTES
		setSunriseSunsetState SUN_STATE_SUNRISE_STOREASBCD
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_SUNRISE_STOREMINUTE
 ; TODO: NOT USED...
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
		; TODO: CONVERT sunriseHourBcd TO BCD - ALTHOUGH NOT NECESSARY IN THE
		; UK (50-60 DEGREES LATITUDE) AS ALL TIMES ARE BEFORE 10:00 !
		banksel sunriseMinuteBcd
		movf sunriseMinuteBcd, W
		banksel RAA
		movwf RAA
		fcall binaryToBcd
		banksel sunriseMinuteBcd
		movwf sunriseMinuteBcd

		setSunriseSunsetState SUN_STATE_CALCULATESUNSET
		returnFromSunriseSunsetState

	end
