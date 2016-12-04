	#include "Mcu.inc"

	radix decimal

	udata_shr
contextSavingW res 1
contextSavingStatus res 1
contextSavingPclath res 1

IsrDummy code 0x0004
saveContext:
	movwf contextSavingW
	swapf contextSavingW
	swapf STATUS, W
	movwf contextSavingStatus
	movf PCLATH, W
	movwf contextSavingPclath
	clrf PCLATH

resetAllInterruptFlags:
	banksel INTCON
	bcf INTCON, T0IF
	bcf INTCON, INTF
	bcf INTCON, RABIF

	banksel PIR1
	clrf PIR1

	banksel PIR2
	clrf PIR2

endOfIsr:
	movf contextSavingPclath, W
	movwf PCLATH
	swapf contextSavingStatus, W
	movwf STATUS
	swapf contextSavingW, W
	retfie

	end
