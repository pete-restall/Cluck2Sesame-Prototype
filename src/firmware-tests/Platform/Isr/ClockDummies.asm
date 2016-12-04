	#include "Mcu.inc"
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

clockYearBcd res 1
clockMonthBcd res 1
clockDayBcd res 1
clockHourBcd res 1
clockMinuteBcd res 1
clockSecondBcd res 1
clockFlags res 1

ClockDummies code
	global initialiseClock
	global pollClock

initialiseClock:
pollClock:
	return

	end
