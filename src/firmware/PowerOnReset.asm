	#include "p16f685.inc"
	#include "TailCalls.inc"

	radix decimal

	extern initialiseAfterReset

PowerOnReset code
	global initialiseAfterPowerOnReset

initialiseAfterPowerOnReset:
	banksel PCON
	movlw (1 << NOT_BOR) | (1 << NOT_POR)
	movwf PCON

	tcall initialiseAfterReset

	end
