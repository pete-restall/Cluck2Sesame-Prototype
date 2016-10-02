	#include "p16f685.inc"
	radix decimal

MclrReset code
	global initialiseAfterMclrReset

initialiseAfterMclrReset:
	banksel PCON
	bsf PCON, NOT_POR
	bsf PCON, NOT_BOR

	return

	end
