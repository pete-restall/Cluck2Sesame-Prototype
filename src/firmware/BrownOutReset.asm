	#include "p16f685.inc"
	radix decimal

BrownOutReset code
	global initialiseAfterBrownOutReset

initialiseAfterBrownOutReset:
	banksel PCON
	bsf PCON, NOT_POR
	bsf PCON, NOT_BOR

	return

	end
