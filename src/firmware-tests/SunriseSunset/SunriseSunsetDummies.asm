	#include "Platform.inc"

	radix decimal

SunriseSunsetRam udata
	global latitudeOffset
	global longitudeOffset
	global sunriseAdjustmentMinutes
	global sunsetAdjustmentMinutes
	global sunriseHourBcd
	global sunriseMinuteBcd
	global sunsetHourBcd
	global sunsetMinuteBcd

latitudeOffset res 1
longitudeOffset res 1
sunriseAdjustmentMinutes res 1
sunsetAdjustmentMinutes res 1
sunriseHourBcd res 1
sunriseMinuteBcd res 1
sunsetHourBcd res 1
sunsetMinuteBcd res 1

SunriseSunset code
	global initialiseSunriseSunset
	global calculateSunriseAndSunset
	global pollSunriseSunset
	global areSunriseAndSunsetValid

initialiseSunriseSunset:
calculateSunriseAndSunset:
pollSunriseSunset:
areSunriseAndSunsetValid:
	return

	end
