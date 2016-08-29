	#include "P16F685.INC"
	radix decimal

	code
	global initialiseAfterPowerOnReset

initialiseAfterPowerOnReset:
	extern isrInitialise

	banksel PCON
	bsf PCON, NOT_POR
	bsf PCON, NOT_BOR

	call isrInitialise
	return

	end
