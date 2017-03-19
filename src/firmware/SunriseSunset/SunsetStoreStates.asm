	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNSET_STORE
		banksel accumulatorLowerLow
		movf accumulatorLowerLow, W
		banksel sunsetHourBcd
		movwf sunsetHourBcd

		banksel accumulatorUpperLow
		movf accumulatorUpperLow, W
		banksel sunsetMinuteBcd
		movwf sunsetMinuteBcd

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
