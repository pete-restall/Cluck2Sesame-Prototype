	#include "Mcu.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNSET_STOREMINUTE
		; TODO: DUMMY VALUES TO ENSURE THE FIRST TEST PASSES - REFINE WITH
		; MORE TESTS
		banksel sunriseHourBcd
		movlw 0x08
		movwf sunriseHourBcd
		movlw 0x33
		movwf sunriseMinuteBcd
		movlw 0x15
		movwf sunsetHourBcd
		movlw 0x32
		movwf sunsetMinuteBcd
		setSunriseSunsetState SUN_STATE_IDLE
		returnFromSunriseSunsetState

	end
