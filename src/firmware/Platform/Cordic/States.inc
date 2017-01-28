	#ifndef __CLUCK2SESAME_PLATFORM_CORDIC_STATES_INC
	#define __CLUCK2SESAME_PLATFORM_CORDIC_STATES_INC

	radix decimal

CORDIC_STATE_IDLE equ 0x00
CORDIC_STATE_SINECOSINEINITIALISE equ 0x01
CORDIC_STATE_CALCULATEERRORFROMZ equ 0x02
CORDIC_STATE_CALCULATEERRORFROMY equ 0x03
CORDIC_STATE_CALCULATEX_SHIFT equ 0x04
CORDIC_STATE_CALCULATEX_ADD equ 0x05
CORDIC_STATE_CALCULATEY_SHIFT equ 0x06
CORDIC_STATE_CALCULATEY_ADD equ 0x07
CORDIC_STATE_CALCULATEZ equ 0x08
CORDIC_STATE_ENDOFITERATION equ 0x09
CORDIC_STATE_STORESINERESULT equ 0x0a
CORDIC_STATE_STORECOSINERESULT equ 0x0b

CORDIC_STATE_LAST equ CORDIC_STATE_STORECOSINERESULT

	#ifndef __CLUCK2SESAME_PLATFORM_CORDIC_POLL_ASM
	extern cordicState
	extern cordicStartOfIterationState
	extern cordicResultState
	extern pollNextInChainAfterCordic
	#endif

setCordicState macro state
	banksel cordicState
	movlw state
	movwf cordicState
	endm

setCordicStartOfIterationState macro state
	banksel cordicStartOfIterationState
	movlw state
	movwf cordicStartOfIterationState
	endm

moveToNextCordicState macro
	banksel cordicNextState
	movf cordicNextState, W
	movwf cordicState
	endm

setCordicResultState macro state
	banksel cordicResultState
	movlw state
	movwf cordicResultState
	endm

defineCordicStateInSameSection macro name
	global cordicState#v(name)

cordicState#v(name):
	endm

defineCordicState macro name
Cordic code
	defineCordicStateInSameSection name
	endm

defineCordicStateTableEntry macro i
	if (i <= CORDIC_STATE_LAST)
		extern cordicState#v(i)
		goto cordicState#v(i)
		defineCordicStateTableEntry i + 1
	endif
	endm

createCordicStateTable macro
	defineCordicStateTableEntry 0
	endm

returnFromCordicState macro
	goto pollNextInChainAfterCordic
	endm

returnZeroIfNotIdle macro
	#if CORDIC_STATE_IDLE != 0
	error "Expected CORDIC_STATE_IDLE to be zero !"
	#endif

	banksel cordicState
	movf cordicState
	btfss STATUS, Z
	retlw 0
	endm

	#endif
