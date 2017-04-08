	#include "Platform.inc"

	radix decimal

	extern POLL_AFTER_CLOCK

ClockRam udata
	global clockFlags
	global clockYearBcd
	global clockMonthBcd
	global clockDayBcd
	global clockHourBcd
	global clockMinuteBcd
	global clockSecondBcd
	global dayOfYearHigh
	global dayOfYearLow

clockFlags res 1
clockYearBcd res 1
clockMonthBcd res 1
clockDayBcd res 1
clockHourBcd res 1
clockMinuteBcd res 1
clockSecondBcd res 1
dayOfYearHigh res 1
dayOfYearLow res 1

	end
