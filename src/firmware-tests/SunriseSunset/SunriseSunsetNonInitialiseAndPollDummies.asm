	#include "Platform.inc"

	radix decimal

SunriseSunsetRam udata
	global latitudeOffset
	global longitudeOffset
	global sunriseHourBcd
	global sunriseMinuteBcd
	global sunsetHourBcd
	global sunsetMinuteBcd

latitudeOffset res 1
longitudeOffset res 1
sunriseHourBcd res 1
sunriseMinuteBcd res 1
sunsetHourBcd res 1
sunsetMinuteBcd res 1

SunriseSunsetNonInitialiseAndPollDummies code
	global calculateSunriseAndSunset
	global areSunriseAndSunsetValid

calculateSunriseAndSunset:
areSunriseAndSunsetValid:
	return

	end
