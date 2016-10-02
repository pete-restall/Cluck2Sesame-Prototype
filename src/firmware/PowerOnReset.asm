	#include "p16f685.inc"
	#include "TailCalls.inc"
	radix decimal

PowerOnReset code
	global initialiseAfterPowerOnReset

initialiseAfterPowerOnReset:
	extern isrInitialise

	banksel PCON
	bsf PCON, NOT_POR
	bsf PCON, NOT_BOR

	tcall isrInitialise

	end
