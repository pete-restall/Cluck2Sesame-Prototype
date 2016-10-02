	#include "p16f685.inc"
	#include "FarCalls.inc"
	radix decimal

	extern initialiseAfterPowerOnReset
	extern initialiseAfterBrownOutReset
	extern initialiseAfterMclrReset
	extern pollForWork

Main code
	global main

main:
	banksel PCON
	btfss PCON, NOT_POR
	goto powerOnReset
	btfss PCON, NOT_BOR
	goto brownOutReset

mclrReset:
	fcall initialiseAfterMclrReset
	goto pollingLoop

powerOnReset:
	fcall initialiseAfterPowerOnReset
	goto pollingLoop

brownOutReset:
	fcall initialiseAfterBrownOutReset

pollingLoop:
	fcall pollForWork
	goto pollingLoop

	end
