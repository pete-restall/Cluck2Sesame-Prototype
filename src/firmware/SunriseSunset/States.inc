	#ifndef __CLUCK2SESAME_SUNRISESUNSET_STATES_INC
	#define __CLUCK2SESAME_SUNRISESUNSET_STATES_INC

	radix decimal

SUN_STATE_UNINITIALISED equ 0x00
SUN_STATE_IDLE equ 0x01
SUN_STATE_CALCULATESUNRISE equ 0x02
SUN_STATE_SUNRISE_LOADLOOKUPS equ 0x03
SUN_STATE_SUNRISE_LOADLOOKUPS2 equ 0x04
SUN_STATE_LOADLOOKUPS equ 0x05
SUN_STATE_LOADLOOKUPS2 equ 0x06
SUN_STATE_LOADLOOKUPS3 equ 0x07
SUN_STATE_INTERPOLATE_REFERENCE equ 0x08
SUN_STATE_INTERPOLATE_LOOKUP equ 0x09
SUN_STATE_INTERPOLATE_LOOKUP2 equ 0x0a
SUN_STATE_INTERPOLATE_REFERENCE2 equ 0x0b
SUN_STATE_INTERPOLATE_NORTHDELTA equ 0x0c
SUN_STATE_INTERPOLATE_NORTHDELTA2 equ 0x0d
SUN_STATE_INTERPOLATE_SOUTHDELTA equ 0x0e
SUN_STATE_INTERPOLATE_SOUTHDELTA2 equ 0x0f
SUN_STATE_INTERPOLATE_LATITUDE equ 0x10
SUN_STATE_INTERPOLATE_LATITUDE2 equ 0x11
SUN_STATE_INTERPOLATE_LATITUDE3 equ 0x12
SUN_STATE_INTERPOLATE_LONGITUDE equ 0x13
SUN_STATE_INTERPOLATE_LONGITUDE2 equ 0x14
SUN_STATE_ACCUMULATORTOHOURS equ 0x15
SUN_STATE_SUNRISE_STORE equ 0x16
SUN_STATE_SUNRISE_STOREASBCD equ 0x17
SUN_STATE_CALCULATESUNSET equ 0x18
SUN_STATE_SUNSET_LOADLOOKUPS equ 0x19
SUN_STATE_SUNSET_LOADLOOKUPS2 equ 0x1a
SUN_STATE_SUNSET_STORE equ 0x1b
SUN_STATE_SUNSET_STOREASBCD equ 0x1c

SUN_STATE_LAST equ SUN_STATE_SUNSET_STOREASBCD

	#ifndef __CLUCK2SESAME_SUNRISESUNSET_POLL_ASM
	extern pollNextInChainAfterSunriseSunset
	#endif

	extern sunriseSunsetState
	extern sunriseSunsetNextState
	extern sunriseSunsetStoreState

setSunriseSunsetState macro state
	banksel sunriseSunsetState
	movlw state
	movwf sunriseSunsetState
	endm

setSunriseSunsetNextState macro state
	banksel sunriseSunsetNextState
	movlw state
	movwf sunriseSunsetNextState
	endm

setSunriseSunsetStoreState macro state
	banksel sunriseSunsetStoreState
	movlw state
	movwf sunriseSunsetStoreState
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
