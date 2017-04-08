	#ifndef __CLUCK2SESAME_PLATFORM_RESETFLAGS_INC
	#define __CLUCK2SESAME_PLATFORM_RESETFLAGS_INC
	#include "Modules.inc"

	radix decimal

RESET_FLAG_BROWNOUT equ 0

	.module RESETFLAGS

	#ifdef __CLUCK2SESAME_PLATFORM_POWERONRESET_ASM
	.externalVariable resetFlags
	#elifdef __CLUCK2SESAME_PLATFORM_MCLRRESET_ASM
	.externalVariable resetFlags
	#elifdef __CLUCK2SESAME_PLATFORM_BROWNOUTRESET_ASM
	.externalVariable resetFlags
	#endif

	#ifndef __CLUCK2SESAME_PLATFORM_RESETFLAGS_ASM
	extern isLastResetDueToBrownOut
	#endif

	#endif
