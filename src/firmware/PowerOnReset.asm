	#include "P16F685.INC"
	radix decimal

	code
	global initialiseAfterPowerOnReset

initialiseAfterPowerOnReset:
	banksel PCON
	bsf PCON, NOT_POR
	bsf PCON, NOT_BOR
	return

	end
