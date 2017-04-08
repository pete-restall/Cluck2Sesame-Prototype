	#define __CLUCK2SESAME_PLATFORM_POWERONRESET_ASM

	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "ResetFlags.inc"

	radix decimal

	extern initialiseAfterReset

PowerOnReset code
	global initialiseAfterPowerOnReset

initialiseAfterPowerOnReset:
	.safelySetBankFor PCON
	movlw (1 << NOT_BOR) | (1 << NOT_POR)
	movwf PCON

	.setBankFor resetFlags
	clrf resetFlags

	tcall initialiseAfterReset

	end
