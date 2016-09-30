	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TailCalls.inc"
	radix decimal

	code
	global initialiseAfterMclrReset

initialiseAfterMclrReset:
	extern isrInitialise

	banksel PCON
	bsf PCON, NOT_POR
	bsf PCON, NOT_BOR

	tcall isrInitialise

	end
