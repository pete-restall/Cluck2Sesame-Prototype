	#ifndef __CLUCK2SESAME_PLATFORM_CLOCK_INC
	#define __CLUCK2SESAME_PLATFORM_CLOCK_INC
	#include "Platform.inc"

	radix decimal

	.module CLOCK

CLOCK_FLAG_TICKED equ 0

	.externalVariable clockFlags
	.externalVariable clockYearBcd
	.externalVariable clockMonthBcd
	.externalVariable clockDayBcd
	.externalVariable clockHourBcd
	.externalVariable clockMinuteBcd
	.externalVariable clockSecondBcd
	.externalVariable dayOfYearHigh
	.externalVariable dayOfYearLow

	#ifndef __CLUCK2SESAME_PLATFORM_CLOCK_ASM
	extern initialiseClock
	extern pollClock
	extern isDaylightSavingsTime
	#endif

	#endif
