	#include "Platform.inc"
	#include "States.inc"

	radix decimal

SunriseSunset code
	global calculateSunriseAndSunset

calculateSunriseAndSunset:
	.unknownBank
	setSunriseSunsetState SUN_STATE_CALCULATESUNRISE
	return

	end
