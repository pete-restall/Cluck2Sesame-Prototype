	#include "p16f685.inc"
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

	; TODO: ISR CODE GOES HERE...

endOfIsr:
	movf contextSavingPclath
	movwf PCLATH
	swapf contextSavingStatus, W
	movwf STATUS
	swapf contextSavingW, W
	retfie

	end
