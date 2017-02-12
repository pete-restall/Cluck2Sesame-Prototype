	#include "Mcu.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNSET_LATITUDEADJUSTMENT
		; TODO: STATE NEEDS WRITING - THIS IS ANOTHER CURVE FIT OPERATION
		; FOLLOWED BY INTERPOLATION
		setSunriseSunsetState SUN_STATE_SUNSET_LONGITUDEADJUSTMENT
		returnFromSunriseSunsetState

	end
