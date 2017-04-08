	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Buttons.inc"

	radix decimal

	extern INITIALISE_AFTER_BUTTONS

Buttons code
	global initialiseButtons

initialiseButtons:
	.safelySetBankFor ANSELH
	bcf ANSELH, ANS11

	.setBankFor IOCB
	bsf IOCB, IOCB5
	bsf IOCB, IOCB6

	.setBankFor buttonFlags
	clrf buttonFlags
	clrf buttonLastCheckTimestamp
	movlw 0xff
	movwf button1State
	movwf button2State

	tcall INITIALISE_AFTER_BUTTONS

	end
