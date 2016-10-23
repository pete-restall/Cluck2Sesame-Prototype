	#include "p16f685.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"

	radix decimal

NON_TIMER0_MASK equ (1 << NOT_RABPU) | (1 << INTEDG)
PRESCALER_DIVIDE_BY_128 equ b'00000110'

	extern INITIALISE_AFTER_TIMER0

Timer0 code
	global initialiseTimer0

initialiseTimer0:
	banksel OPTION_REG
	movlw NON_TIMER0_MASK
	andwf OPTION_REG
	movlw PRESCALER_DIVIDE_BY_128
	iorwf OPTION_REG
	tcall INITIALISE_AFTER_TIMER0

	end
