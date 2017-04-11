	#ifndef __CLUCK2SESAME_PLATFORM_TIMER0_INC
	#define __CLUCK2SESAME_PLATFORM_TIMER0_INC
	#include "Platform.inc"

	radix decimal

	.module TIMER0

	.externalVariable slowTmr0

	extern initialiseTimer0
	extern pollTimer0

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

storeSlowTimer0 macro slowTicks
	.setBankFor slowTmr0
	movf slowTmr0, W
	.setBankFor slowTicks
	movwf slowTicks
	endm

elapsedSinceSlowTimer0 macro fromSlowTicks
	.setBankFor fromSlowTicks
	movf fromSlowTicks, W
	.setBankFor slowTmr0
	subwf slowTmr0, W
	endm

	#endif
