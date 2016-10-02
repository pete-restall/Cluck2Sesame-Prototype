	#include "p16f685.inc"
	#include "TailCalls.inc"
	radix decimal

BrownOutReset code
	global initialiseAfterBrownOutReset

initialiseAfterBrownOutReset:
	extern isrInitialise

	banksel PCON
	bsf PCON, NOT_POR
	bsf PCON, NOT_BOR

	tcall isrInitialise

	end
