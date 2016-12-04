	#ifndef __CLUCK2SESAME_PLATFORM_TIMER0_INC
	#define __CLUCK2SESAME_PLATFORM_TIMER0_INC

	extern initialiseTimer0

storeTimer0 macro ticks
	banksel TMR0
	movf TMR0, W
	banksel ticks
	movwf ticks
	endm

elapsedSinceTimer0 macro fromTicks
	banksel fromTicks
	movf fromTicks, W
	banksel TMR0
	subwf TMR0, W
	endm

	#endif
