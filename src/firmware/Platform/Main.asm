	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "PowerOnReset.inc"
	#include "BrownOutReset.inc"
	#include "MclrReset.inc"
	#include "PowerManagement.inc"

	radix decimal

	extern pollForWork

Main code
	global main
	global initialisationCompleted

main:
	.safelySetBankFor PCON
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
 fcall preventSleep ; TODO: TEMPORARY !!!!!!!!!!!!!!!!!!!!!!!!
	fcall pollForWork
	goto pollingLoop

initialisationCompleted:
	.safelySetBankFor INTCON
	movlw (1 << GIE) | (1 << PEIE)
	iorwf INTCON

	fcall preventSleep
	fcall pollForWork
	fcall allowSlowClock
	return

	end
