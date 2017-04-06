	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Buttons.inc"

	radix decimal

	extern INITIALISE_AFTER_BUTTONS

Buttons code
	global initialiseButtons

initialiseButtons:
	banksel ANSELH
	bcf ANSELH, ANS11

	banksel IOCB
	bsf IOCB, IOCB5
	bsf IOCB, IOCB6

	banksel buttonFlags
	clrf buttonFlags
	clrf buttonLastCheckTimestamp
	movlw 0xff
	movwf button1State
	movwf button2State

	tcall INITIALISE_AFTER_BUTTONS

	end
