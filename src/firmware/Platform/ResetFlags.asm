	#define __CLUCK2SESAME_RESETFLAGS_ASM

	#include "p16f685.inc"
	#include "ResetFlags.inc"

	radix decimal

	udata
	global resetFlags

resetFlags res 1

ResetFlags code
	global isLastResetDueToBrownOut

isLastResetDueToBrownOut:
	banksel resetFlags
	btfsc resetFlags, RESET_FLAG_BROWNOUT
	retlw 1
	retlw 0

	end
