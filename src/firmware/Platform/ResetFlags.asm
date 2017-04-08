	#define __CLUCK2SESAME_PLATFORM_RESETFLAGS_ASM

	#include "Platform.inc"
	#include "ResetFlags.inc"

	radix decimal

ResetFlagsRam udata
	global resetFlags

resetFlags res 1

ResetFlags code
	global isLastResetDueToBrownOut

isLastResetDueToBrownOut:
	.safelySetBankFor resetFlags
	btfsc resetFlags, RESET_FLAG_BROWNOUT
	retlw 1
	retlw 0

	end
