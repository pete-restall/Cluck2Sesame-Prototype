	#ifndef __CLUCK2SESAME_RESETFLAGS_INC
	#define __CLUCK2SESAME_RESETFLAGS_INC

RESET_FLAG_BROWNOUT equ 0

	#ifdef __CLUCK2SESAME_POWERONRESET_ASM
	extern resetFlags
	#elifdef __CLUCK2SESAME_MCLRRESET_ASM
	extern resetFlags
	#elifdef __CLUCK2SESAME_BROWNOUTRESET_ASM
	extern resetFlags
	#endif

	#ifndef __CLUCK2SESAME_RESETFLAGS_ASM
	extern isLastResetDueToBrownOut
	#endif

	#endif
