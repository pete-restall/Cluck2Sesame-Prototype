	#ifndef __CLUCK2SESAME_PLATFORM_MCU_INC
	#define __CLUCK2SESAME_PLATFORM_MCU_INC
	#include "p16f685.inc"

	#define MCU_FASTCLOCKFREQUENCYHZ 4000000

	errorlevel -305

constrainedToMcuFastClockFrequencyHz macro hz
	#if MCU_FASTCLOCKFREQUENCYHZ != hz
	error "Unexpected MCU oscillator frequency - review this code !"
	#endif
	endm

	#endif
