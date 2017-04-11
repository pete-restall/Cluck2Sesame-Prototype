	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Timer0.inc"

	radix decimal

	constrainedToMcuFastClockFrequencyHz 4000000

NON_TIMER0_MASK equ (1 << NOT_RABPU) | (1 << INTEDG)
PRESCALER_DIVIDE_BY_128 equ b'00000110'

	extern INITIALISE_AFTER_TIMER0

Timer0 code
	global initialiseTimer0

initialiseTimer0:
	.safelySetBankFor slowTmr0
	clrf slowTmr0
	clrf tmr0Overflow

	.setBankFor OPTION_REG
	movlw NON_TIMER0_MASK
	andwf OPTION_REG

	.setBankFor INTCON
	bcf INTCON, T0IF

	.setBankFor TMR0
	clrf TMR0

	.setBankFor OPTION_REG
	movlw PRESCALER_DIVIDE_BY_128
	iorwf OPTION_REG
	tcall INITIALISE_AFTER_TIMER0

	end
