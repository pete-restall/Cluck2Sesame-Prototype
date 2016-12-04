	#define __CLUCK2SESAME_POWERONRESET_ASM

	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "ResetFlags.inc"

	radix decimal

	extern initialiseAfterReset

PowerOnReset code
	global initialiseAfterPowerOnReset

initialiseAfterPowerOnReset:
	banksel PCON
	movlw (1 << NOT_BOR) | (1 << NOT_POR)
	movwf PCON

	banksel resetFlags
	clrf resetFlags

	tcall initialiseAfterReset

	end
