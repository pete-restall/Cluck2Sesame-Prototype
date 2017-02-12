	#ifndef __CLUCK2SESAME_SUNRISESUNSET_STATES_INC
	#define __CLUCK2SESAME_SUNRISESUNSET_STATES_INC

	radix decimal

SUN_STATE_UNINITIALISED equ 0x00
SUN_STATE_IDLE equ 0x01
SUN_STATE_CALCULATESUNRISE equ 0x02
SUN_STATE_SUNRISE_LIMITDAYOFYEAR equ 0x03
SUN_STATE_DAYOFYEAR equ 0x04
SUN_STATE_CURVEFIT1 equ 0x05
SUN_STATE_CURVEFIT2 equ 0x06
SUN_STATE_CURVEFIT3 equ 0x07
SUN_STATE_CURVEFIT4 equ 0x08
SUN_STATE_CURVEFIT5 equ 0x09
SUN_STATE_CURVEFIT6 equ 0x0a
SUN_STATE_CURVEFIT7 equ 0x0b
SUN_STATE_SUNRISE_LATITUDEADJUSTMENT equ 0x0c
SUN_STATE_SUNRISE_LONGITUDEADJUSTMENT equ 0x0d
SUN_STATE_ACCUMULATORTOHOURS equ 0x0e
SUN_STATE_SUNRISE_STOREHOUR equ 0x0f
SUN_STATE_ACCUMULATORTOMINUTES equ 0x10
SUN_STATE_SUNRISE_STOREMINUTE equ 0x11
SUN_STATE_SUNRISE_STOREASBCD equ 0x12
SUN_STATE_SUNSET_STOREMINUTE equ 0x13

SUN_STATE_LAST equ SUN_STATE_SUNSET_STOREMINUTE

	#ifndef __CLUCK2SESAME_SUNRISESUNSET_POLL_ASM
	extern pollNextInChainAfterSunriseSunset
	#endif

	extern sunriseSunsetState
	extern sunriseSunsetNextState

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
