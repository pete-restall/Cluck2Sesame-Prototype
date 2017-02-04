	#include "Mcu.inc"
	#include "States.inc"

	radix decimal

SunriseSunset code
	global calculateSunriseAndSunset

calculateSunriseAndSunset:
	setSunriseSunsetState SUN_STATE_STORESUNSET_MINUTE
	return

	end
