	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Buttons.inc"

	radix decimal

	extern INITIALISE_AFTER_BUTTONS

Buttons code
	global initialiseButtons

initialiseButtons:
	banksel IOCB
	bsf IOCB, IOCB5
	bsf IOCB, IOCB6

	banksel button1State
	clrf button1State
	clrf button2State

	tcall INITIALISE_AFTER_BUTTONS

	end
