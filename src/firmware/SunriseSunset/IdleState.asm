	#include "Mcu.inc"
	#include "States.inc"

	radix decimal

	global areSunriseAndSunsetValid

	defineSunriseSunsetState SUN_STATE_IDLE
	returnFromSunriseSunsetState

areSunriseAndSunsetValid:
	; TODO: WHEN BOOTED (STATE UNINITIALISED), THIS SHOULD RETURN 0
	; TODO: WHEN CALCULATIONS ARE IN PROGRESS, THIS SHOULD RETURN 0
	; TODO: WHEN CALCULATIONS ARE COMPLETE (STATE IDLE), THIS SHOULD RETURN 1
	retlw 1

	end
