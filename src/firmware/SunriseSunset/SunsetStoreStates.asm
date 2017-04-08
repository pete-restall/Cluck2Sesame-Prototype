	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNSET_STORE
		.setBankFor accumulatorLowerLow
		movf accumulatorLowerLow, W
		.setBankFor sunsetHourBcd
		movwf sunsetHourBcd

		.setBankFor accumulatorUpperLow
		movf accumulatorUpperLow, W
		.setBankFor sunsetMinuteBcd
		movwf sunsetMinuteBcd

		setSunriseSunsetState SUN_STATE_SUNSET_STOREASBCD
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_SUNSET_STOREASBCD
		.setBankFor sunsetHourBcd
		movf sunsetHourBcd, W
		.setBankFor RAA
		movwf RAA
		fcall binaryToBcd
		.setBankFor sunsetHourBcd
		movwf sunsetHourBcd

		movf sunsetMinuteBcd, W
		.setBankFor RAA
		movwf RAA
		fcall binaryToBcd
		.setBankFor sunsetMinuteBcd
		movwf sunsetMinuteBcd

		setSunriseSunsetState SUN_STATE_IDLE
		returnFromSunriseSunsetState

	end
