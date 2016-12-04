	#define __CLUCK2SESAME_PLATFORM_BROWNOUTRESET_ASM

	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "ResetFlags.inc"

	radix decimal

	extern initialiseAfterReset

BrownOutReset code
	global initialiseAfterBrownOutReset

initialiseAfterBrownOutReset:
	banksel PCON
	movlw (1 << NOT_BOR) | (1 << NOT_POR)
	movwf PCON

	banksel resetFlags
	movlw 1 << RESET_FLAG_BROWNOUT
	movwf resetFlags

	tcall initialiseAfterReset

	end
