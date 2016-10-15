	#include "p16f685.inc"
	#include "TailCalls.inc"

	radix decimal

	extern initialiseAfterReset

BrownOutReset code
	global initialiseAfterBrownOutReset

initialiseAfterBrownOutReset:
	banksel PCON
	movlw (1 << NOT_BOR) | (1 << NOT_POR)
	movwf PCON

	tcall initialiseAfterReset

	end
