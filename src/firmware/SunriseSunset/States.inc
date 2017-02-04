	#ifndef __CLUCK2SESAME_SUNRISESUNSET_STATES_INC
	#define __CLUCK2SESAME_SUNRISESUNSET_STATES_INC

	radix decimal

SUN_STATE_UNINITIALISED equ 0x00
SUN_STATE_IDLE equ 0x01
SUN_STATE_STORESUNSET_MINUTE equ 0x02

SUN_STATE_LAST equ SUN_STATE_STORESUNSET_MINUTE

	#ifndef __CLUCK2SESAME_SUNRISESUNSET_POLL_ASM
	extern pollNextInChainAfterSunriseSunset
	#endif

	extern sunriseSunsetState

setSunriseSunsetState macro state
	banksel sunriseSunsetState
	movlw state
	movwf sunriseSunsetState
	endm

defineSunriseSunsetStateInSameSection macro name
	global sunriseSunsetState#v(name)

sunriseSunsetState#v(name):
	endm

defineSunriseSunsetState macro name
SunriseSunset code
	defineSunriseSunsetStateInSameSection name
	endm

defineSunriseSunsetStateTableEntry macro i
	if (i <= SUN_STATE_LAST)
		extern sunriseSunsetState#v(i)
		goto sunriseSunsetState#v(i)
		defineSunriseSunsetStateTableEntry i + 1
	endif
	endm

createSunriseSunsetStateTable macro
	defineSunriseSunsetStateTableEntry 0
	endm

returnFromSunriseSunsetState macro
	goto pollNextInChainAfterSunriseSunset
	endm

	#endif
