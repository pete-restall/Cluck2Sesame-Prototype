	#define __CLUCK2SESAME_MCLRRESET_ASM

	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "ResetFlags.inc"

	radix decimal

	extern initialiseAfterReset

MclrReset code
	global initialiseAfterMclrReset

initialiseAfterMclrReset:
	banksel PCON
	movlw (1 << NOT_BOR) | (1 << NOT_POR)
	movwf PCON

	banksel resetFlags
	clrf resetFlags

	tcall initialiseAfterReset

	end
