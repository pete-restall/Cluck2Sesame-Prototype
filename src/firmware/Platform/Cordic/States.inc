	#ifndef __CLUCK2SESAME_PLATFORM_CORDIC_STATES_INC
	#define __CLUCK2SESAME_PLATFORM_CORDIC_STATES_INC

	radix decimal

CORDIC_STATE_IDLE equ 0x00
CORDIC_STATE_SINECOSINEINITIALISE equ 0x01
CORDIC_STATE_ITERATION equ 0x02
CORDIC_STATE_STORESINECOSINERESULT equ 0x03

CORDIC_STATE_LAST equ CORDIC_STATE_STORESINECOSINERESULT

	#ifndef __CLUCK2SESAME_PLATFORM_CORDIC_POLL_ASM
	extern cordicState
	extern cordicNextState
	extern pollNextInChainAfterCordic
	#endif

setCordicState macro state
	banksel cordicState
	movlw state
	movwf cordicState
	endm

setCordicNextState macro state
	banksel cordicNextState
	movlw state
	movwf cordicNextState
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
