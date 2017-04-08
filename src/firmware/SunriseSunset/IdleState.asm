	#include "Platform.inc"
	#include "States.inc"

	radix decimal

	global areSunriseAndSunsetValid

	defineSunriseSunsetState SUN_STATE_IDLE
	returnFromSunriseSunsetState

areSunriseAndSunsetValid:
	; TODO: WHEN BOOTED (STATE UNINITIALISED), THIS SHOULD RETURN 0
	; TODO: WHEN CALCULATIONS ARE IN PROGRESS, THIS SHOULD RETURN 0
	; TODO: WHEN CALCULATIONS ARE COMPLETE (STATE IDLE), THIS SHOULD RETURN 1
	.safelySetBankFor sunriseSunsetState
	movf sunriseSunsetState, W
	xorlw SUN_STATE_IDLE
	btfsc STATUS, Z
	retlw 1
	retlw 0

	end
