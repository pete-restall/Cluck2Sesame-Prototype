	#include "p16f685.inc"
	#include "FarCalls.inc"
	radix decimal

	extern initialiseAfterPowerOnReset
	extern initialiseAfterBrownOutReset
	extern initialiseAfterMclrReset
	global main

	code
main:
	banksel PCON
	btfss PCON, NOT_POR
	goto powerOnReset
	btfss PCON, NOT_BOR
	goto brownOutReset

mclrReset:
	fcall initialiseAfterMclrReset
	return

powerOnReset:
	fcall initialiseAfterPowerOnReset
	return ; TODO: TEMPORARY !  JUST FOR TESTS AT PRESENT (TO ALLOW 'call main')

brownOutReset:
	fcall initialiseAfterBrownOutReset

	return ; TODO: TEMPORARY !  JUST FOR TESTS AT PRESENT (TO ALLOW 'call main')

	end
