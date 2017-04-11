	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"
	#include "Timer0.inc"

	radix decimal

	extern POLL_AFTER_TIMER0

Timer0 code
	global pollTimer0

pollTimer0:
	btfss INTCON, T0IF
	goto pollNextInChain
	bcf INTCON, T0IF

	.safelySetBankFor tmr0Overflow
	incf tmr0Overflow
	movlw 7
	andwf tmr0Overflow
	btfsc STATUS, Z
	incf slowTmr0

pollNextInChain:
	tcall POLL_AFTER_TIMER0

	end
