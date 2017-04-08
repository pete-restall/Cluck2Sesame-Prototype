	#ifndef __CLUCK2SESAME_PLATFORM_TAILCALLS_INC
	#define __CLUCK2SESAME_PLATFORM_TAILCALLS_INC
	#include "FarCalls.inc"

	radix decimal

tcall macro destination
	fgoto destination
	endm

	#endif
