	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "PowerOnReset.inc"
	#include "BrownOutReset.inc"
	#include "MclrReset.inc"

	radix decimal

	extern pollForWork

Main code
	global main
	global initialisationCompleted

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

initialisationCompleted:
	return

	end
