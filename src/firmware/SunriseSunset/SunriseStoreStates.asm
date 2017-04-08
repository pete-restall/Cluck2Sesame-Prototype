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
		; TODO: CONVERT sunriseHourBcd TO BCD - ALTHOUGH NOT NECESSARY IN THE
		; UK (50-60 DEGREES LATITUDE) AS ALL TIMES ARE BEFORE 10:00 !
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
