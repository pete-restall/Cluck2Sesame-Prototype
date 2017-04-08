	#ifndef __CLUCK2SESAME_PLATFORM_SHIFTREGISTER_INC
	#define __CLUCK2SESAME_PLATFORM_SHIFTREGISTER_INC
	#include "Modules.inc"

	radix decimal

	.module SHIFTREGISTER

	.externalVariable shiftRegisterBuffer

	extern initialiseShiftRegister
	extern enableShiftRegister
	extern disableShiftRegister
	extern isShiftRegisterEnabled
	extern shiftOut

	#endif
