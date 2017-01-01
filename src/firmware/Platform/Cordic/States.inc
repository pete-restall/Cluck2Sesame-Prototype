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
CORDIC_STATE_ARCSINEINITIALISE equ 0x0c
CORDIC_STATE_ARCSINEINITIALISE2 equ 0x0d
CORDIC_STATE_ARCSINEINITIALISE3 equ 0x0e
CORDIC_STATE_SQRTINITIALISE equ 0x0f
CORDIC_STATE_SQRTINITIALISE2 equ 0x10
CORDIC_STATE_HYPERBOLIC_CALCULATEX_SHIFT equ 0x11
CORDIC_STATE_HYPERBOLIC_CALCULATEX_ADD equ 0x12
CORDIC_STATE_HYPERBOLIC_CALCULATEY_SHIFT equ 0x13
CORDIC_STATE_HYPERBOLIC_CALCULATEY_ADD equ 0x14
CORDIC_STATE_HYPERBOLIC_ENDOFITERATION equ 0x15
CORDIC_STATE_STORESQRTINTERMEDIATERESULT equ 0x16
CORDIC_STATE_STORESQRTINTERMEDIATERESULT2 equ 0x17
CORDIC_STATE_ARCTANGENTINITIALISE equ 0x18
CORDIC_STATE_STOREARCSINERESULT equ 0x19
CORDIC_STATE_STOREARCCOSINERESULT equ 0x1a

CORDIC_STATE_LAST equ CORDIC_STATE_STOREARCCOSINERESULT

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

	#endif
