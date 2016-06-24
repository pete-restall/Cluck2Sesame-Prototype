	#include "P16F685.INC"
	radix decimal

	code
	global initialiseAfterBrownOutReset

initialiseAfterBrownOutReset:
	banksel PCON
	bsf PCON, NOT_POR
	bsf PCON, NOT_BOR
	return

	end
