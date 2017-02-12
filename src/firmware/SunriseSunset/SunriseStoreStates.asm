	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNRISE_STOREHOUR
		banksel accumulator
		movf accumulatorUpperLow, W
		; TODO: FCALL binaryToBcd() HERE -> TAKES W, OUTPUTS W !
		; FIND A SUNSET OVER 10:00 FOR WRITING THE TEST FOR THIS !
		movwf sunriseHourBcd

		setSunriseSunsetNextState SUN_STATE_SUNRISE_STOREMINUTE
		setSunriseSunsetState SUN_STATE_ACCUMULATORTOMINUTES
		returnFromSunriseSunsetState


	defineSunriseSunsetStateInSameSection SUN_STATE_SUNRISE_STOREMINUTE
		; TODO: STATE NEEDS WRITING - TRIGGER SUNSET CALCULATIONS AFTER
		banksel sunriseMinuteBcd
		movlw 0x33
		movwf sunriseMinuteBcd
		setSunriseSunsetState SUN_STATE_SUNSET_STOREMINUTE
		returnFromSunriseSunsetState

	end
