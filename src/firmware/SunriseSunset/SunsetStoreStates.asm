	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNSET_STOREHOUR
		banksel accumulator
		movf accumulatorUpperLow, W
		movwf sunsetHourBcd

		setSunriseSunsetNextState SUN_STATE_SUNSET_STOREMINUTE
		setSunriseSunsetState SUN_STATE_ACCUMULATORTOMINUTES
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_SUNSET_STOREMINUTE
		banksel accumulator
		movf accumulatorUpperLow, W
		movwf sunsetMinuteBcd
		btfsc accumulatorLowerHigh, 7
		incf sunsetMinuteBcd

		; TODO: WHEN ROUNDING UP, NEED TO INCREMENT HOUR IF MINUTE == 59 AND
		; ROUNDED TO 00
		setSunriseSunsetState SUN_STATE_SUNSET_STOREASBCD
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_SUNSET_STOREASBCD
		banksel sunsetHourBcd
		movf sunsetHourBcd, W
		banksel RAA
		movwf RAA
		fcall binaryToBcd
		banksel sunsetHourBcd
		movwf sunsetHourBcd

		movf sunsetMinuteBcd, W
		banksel RAA
		movwf RAA
		fcall binaryToBcd
		banksel sunsetMinuteBcd
		movwf sunsetMinuteBcd

		setSunriseSunsetState SUN_STATE_IDLE
		returnFromSunriseSunsetState

	end
