	#include "Mcu.inc"

	radix decimal

	udata
	global latitudeOffset
	global longitudeOffset
	global sunriseHourBcd
	global sunriseMinuteBcd
	global sunsetHourBcd
	global sunsetMinuteBcd
	global sunriseSunsetState
	global accumulator
	global accumulatorUpperHigh
	global accumulatorUpperLow
	global accumulatorLowerHigh
	global accumulatorLowerLow
	global coefficient
	global coefficientHigh
	global coefficientLow
	global coefficientIndex

latitudeOffset res 1
longitudeOffset res 1
sunriseHourBcd res 1
sunriseMinuteBcd res 1
sunsetHourBcd res 1
sunsetMinuteBcd res 1

sunriseSunsetState res 1

accumulator:
accumulatorUpperHigh res 1
accumulatorUpperLow res 1
accumulatorLowerHigh res 1
accumulatorLowerLow res 1

coefficient:
coefficientHigh res 1
coefficientLow res 1

coefficientIndex res 1

	end
