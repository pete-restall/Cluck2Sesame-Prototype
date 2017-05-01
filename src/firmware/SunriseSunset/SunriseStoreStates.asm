	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNRISE_STORE
		.setBankFor accumulatorLowerLow
		movf accumulatorLowerLow, W
		.setBankFor sunriseHourBcd
		movwf sunriseHourBcd

		.setBankFor accumulatorUpperLow
		movf accumulatorUpperLow, W
		.setBankFor sunriseMinuteBcd
		movwf sunriseMinuteBcd

		setSunriseSunsetState SUN_STATE_SUNRISE_STOREASBCD
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_SUNRISE_STOREASBCD
		.setBankFor sunriseHourBcd
		movf sunriseHourBcd, W
		.setBankFor RAA
		movwf RAA
		fcall binaryToBcd
		.setBankFor sunriseHourBcd
		movwf sunriseHourBcd

		.setBankFor sunriseMinuteBcd
		movf sunriseMinuteBcd, W
		.setBankFor RAA
		movwf RAA
		fcall binaryToBcd
		.setBankFor sunriseMinuteBcd
		movwf sunriseMinuteBcd

		setSunriseSunsetState SUN_STATE_CALCULATESUNSET
		returnFromSunriseSunsetState

	end
