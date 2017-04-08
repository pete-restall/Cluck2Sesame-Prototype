	#ifndef __CLUCK2SESAME_PLATFORM_MODULEDEFINITIONS_INC
	#define __CLUCK2SESAME_PLATFORM_MODULEDEFINITIONS_INC
	#include "Modules.inc"

	radix decimal

	; Make sure that these tally with the linker script !

	.defineModule ADC, BANK0
	.defineModule ARITHMETIC4, BANK0
	.defineModule ARITHMETIC16, BANK0
	.defineModule ARITHMETIC32, BANK0
	.defineModule ARITHMETICBCD, BANK0
	.defineModule BROWNOUTRESET, BANK0
	.defineModule BUTTONS, BANK0
	.defineModule CLOCK, BANK0
	.defineModule FLASH, BANK0
	.defineModule GENERALPURPOSEREGISTERS, BANK0
	.defineModule ISR, BANK0
	.defineModule LCD, BANK0
	.defineModule MCLRRESET, BANK0
	.defineModule MOTOR, BANK0
	.defineModule POWERMANAGEMENT, BANK0
	.defineModule RESETFLAGS, BANK0
	.defineModule SHIFTREGISTER, BANK0
	.defineModule SMPS, BANK0

	.defineModule DOOR, BANK1
	.defineModule SUNRISESUNSET, BANK1
	.defineModule UI, BANK1

	#endif
