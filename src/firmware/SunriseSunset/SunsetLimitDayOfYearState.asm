	#include "Mcu.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNSET_LIMITDAYOFYEAR
setNextState:
		setSunriseSunsetState SUN_STATE_DAYOFYEAR
		returnFromSunriseSunsetState

	end
