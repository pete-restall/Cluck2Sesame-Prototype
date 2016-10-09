	#include "p16f685.inc"
	#include "Clock.inc"
	radix decimal

	udata_shr
contextSavingW res 1
contextSavingStatus res 1
contextSavingPclath res 1

Isr code 0x0004
	; Context saving - note swapf does not alter any STATUS bits, movf does:

	movwf contextSavingW
	swapf contextSavingW
	swapf STATUS, W
	movwf contextSavingStatus
	movf PCLATH, W
	movwf contextSavingPclath
	clrf PCLATH

clockTicked:
	banksel clockFlags
	bsf clockFlags, CLOCK_FLAG_TICKED

	banksel PIR1
	bcf PIR1, TMR1IF

endOfIsr:
	movf contextSavingPclath, W
	movwf PCLATH
	swapf contextSavingStatus, W
	movwf STATUS
	swapf contextSavingW, W
	retfie

	end
