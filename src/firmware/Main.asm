	#include "p16f685.inc"
	#include "FarCalls.inc"
	radix decimal

	extern initialiseAfterPowerOnReset
	extern initialiseAfterBrownOutReset
	global main

	code
main:
	banksel PCON
	btfss PCON, NOT_POR
	goto powerOnReset
	goto brownOutReset

powerOnReset:
	fcall initialiseAfterPowerOnReset
	return

brownOutReset:
	fcall initialiseAfterBrownOutReset

	return ; TODO: TEMPORARY !  JUST FOR TESTS AT PRESENT (TO ALLOW 'call main')

	end
