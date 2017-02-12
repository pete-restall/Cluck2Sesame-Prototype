	#include "Mcu.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNSET_LONGITUDEADJUSTMENT
		; TODO: STATE NEEDS WRITING
		setSunriseSunsetNextState SUN_STATE_SUNSET_STOREHOUR
		setSunriseSunsetState SUN_STATE_ACCUMULATORTOHOURS
		returnFromSunriseSunsetState

	end
