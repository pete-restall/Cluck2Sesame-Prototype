	#ifndef __CLUCK2SESAME_PLATFORM_TIMER0_INC
	#define __CLUCK2SESAME_PLATFORM_TIMER0_INC

	radix decimal

	extern initialiseTimer0

storeTimer0 macro ticks
	.setBankFor TMR0
	movf TMR0, W
	.setBankFor ticks
	movwf ticks
	endm

elapsedSinceTimer0 macro fromTicks
	.setBankFor fromTicks
	movf fromTicks, W
	.setBankFor TMR0
	subwf TMR0, W
	endm

	#endif
