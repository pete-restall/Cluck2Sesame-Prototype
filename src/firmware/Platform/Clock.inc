	#ifndef __CLUCK2SESAME_PLATFORM_CLOCK_INC
	#define __CLUCK2SESAME_PLATFORM_CLOCK_INC

	radix decimal

CLOCK_FLAG_TICKED equ 0

	#ifndef __CLUCK2SESAME_PLATFORM_CLOCK_ASM
	extern initialiseClock
	extern pollClock
	#endif

	extern clockFlags
	extern clockYearBcd
	extern clockMonthBcd
	extern clockDayBcd
	extern clockHourBcd
	extern clockMinuteBcd
	extern clockSecondBcd
	extern dayOfYearHigh
	extern dayOfYearLow

	#endif
