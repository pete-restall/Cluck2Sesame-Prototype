	#include "Platform.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global clockYearBcd
	global clockMonthBcd
	global clockDayBcd
	global clockHourBcd
	global clockMinuteBcd
	global clockSecondBcd
	global clockFlags
	global dayOfYearHigh
	global dayOfYearLow

clockYearBcd res 1
clockMonthBcd res 1
clockDayBcd res 1
clockHourBcd res 1
clockMinuteBcd res 1
clockSecondBcd res 1
clockFlags res 1
dayOfYearHigh res 1
dayOfYearLow res 1

ClockDummies code
	global initialiseClock
	global pollClock

initialiseClock:
pollClock:
	return

	end
