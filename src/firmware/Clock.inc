	#ifndef __CLUCK2SESAME_CLOCK_INC
	#define __CLUCK2SESAME_CLOCK_INC

CLOCK_FLAG_TICKED equ 0

	#ifndef __CLUCK2SESAME_CLOCK_ASM
	extern initialiseClock
	extern pollClock

	extern clockFlags
	extern clockYearBcd
	extern clockMonthBcd
	extern clockDayBcd
	extern clockHourBcd
	extern clockMinuteBcd
	extern clockSecondBcd
	#endif

	#endif
