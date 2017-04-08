	#include "Platform.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"
	#include "Timer0.inc"
	#include "Buttons.inc"

	radix decimal

	extern POLL_AFTER_BUTTONS

NUMBER_OF_TICKS_6_25MS equ 49

Buttons code
	global pollButtons

pollButtons:
	.unknownBank
	elapsedSinceTimer0 buttonLastCheckTimestamp
	sublw NUMBER_OF_TICKS_6_25MS
	btfsc STATUS, C
	goto endOfButtonPoll

	storeTimer0 buttonLastCheckTimestamp

	.setBankFor PORTB
	movlw (1 << RB5) | (1 << RB6)
	andwf PORTB, W

	.setBankFor buttonSnapshot
	movwf buttonSnapshot
	rlf buttonSnapshot

shiftbuttonStateIntoIndividualBuffers:
	rlf buttonSnapshot
	rlf button1State
	rlf buttonSnapshot
	rlf button2State

noButtonsPressedWillResetState:
	clrf buttonFlags
	movf button1State, W
	andwf button2State, W
	andlw 0x0f
	xorlw 0x0f
	btfsc STATUS, Z
	goto endOfButtonPoll

bothButtonsPressedWillSetState:
	movf button1State, W
	iorwf button2State, W
	andlw 0x0f
	btfsc STATUS, Z
	goto bothPressed

oneButtonPressedAndTheOtherNotPressedWillSetState:
	movf button1State, W
	andlw 0x0f
	btfsc STATUS, Z
	bsf buttonFlags, BUTTON_FLAG_PRESSED1

	movf button2State, W
	andlw 0x0f
	btfsc STATUS, Z
	bsf buttonFlags, BUTTON_FLAG_PRESSED2

	movf buttonFlags, W
	xorlw BUTTON_FLAG_PRESSED1_MASK | BUTTON_FLAG_PRESSED2_MASK
	btfsc STATUS, Z
	clrf buttonFlags

	goto endOfButtonPoll

bothPressed:
	bsf buttonFlags, BUTTON_FLAG_PRESSEDBOTH

endOfButtonPoll:
	tcall POLL_AFTER_BUTTONS

	end
