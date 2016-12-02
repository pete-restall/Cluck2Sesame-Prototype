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
	; TODO: FOR LOW POWER CONSUMPTION WE SHOULD BE ABLE TO SWITCH TO LFINTOSC
	;       AND ONLY POLL A SUBSET OF MODULES (IE. CLOCK) IN THAT MODE.  WHEN
	;       NON-TIMEKEEPING NEEDS TO BE DONE WE CAN SWITCH BACK INTO HFINTOSC
	;       MODE AND START CALLING pollForWork() AGAIN.
	fcall pollForWork
	goto pollingLoop

initialisationCompleted:
	banksel INTCON
	movlw (1 << GIE) | (1 << PEIE)
	iorwf INTCON
	return

	end
