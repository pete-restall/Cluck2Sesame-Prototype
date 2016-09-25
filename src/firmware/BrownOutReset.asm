	#include "p16f685.inc"
	radix decimal

	code
	global initialiseAfterBrownOutReset

initialiseAfterBrownOutReset:
	extern isrInitialise

	banksel PCON
	bsf PCON, NOT_POR
	bsf PCON, NOT_BOR

	call isrInitialise
	return

	end
