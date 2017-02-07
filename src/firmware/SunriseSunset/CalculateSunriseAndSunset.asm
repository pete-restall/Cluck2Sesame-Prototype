	#include "Mcu.inc"
	#include "States.inc"

	radix decimal

SunriseSunset code
	global calculateSunriseAndSunset

calculateSunriseAndSunset:
	setSunriseSunsetState SUN_STATE_CALCULATESUNRISE
	return

	end
