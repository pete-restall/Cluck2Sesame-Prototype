	#include "Mcu.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNRISE_LONGITUDEADJUSTMENT
		; TODO: STATE NEEDS WRITING
		setSunriseSunsetNextState SUN_STATE_SUNRISE_STOREHOUR
		setSunriseSunsetState SUN_STATE_ACCUMULATORTOHOURS
		returnFromSunriseSunsetState

	end
