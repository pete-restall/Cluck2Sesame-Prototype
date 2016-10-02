	#include "p16f685.inc"
	radix decimal

PowerOnReset code
	global initialiseAfterPowerOnReset

initialiseAfterPowerOnReset:
	banksel PCON
	bsf PCON, NOT_POR
	bsf PCON, NOT_BOR

	return

	end
