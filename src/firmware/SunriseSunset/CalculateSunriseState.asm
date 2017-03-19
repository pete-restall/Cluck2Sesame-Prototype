	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_CALCULATESUNRISE
		call loadDayOfYearIntoA
		call loadLookupStepIntoLowerB
		fcall div32x16
		call storeLookupIndexFromA

		setSunriseSunsetState SUN_STATE_SUNRISE_LOADLOOKUPS
		returnFromSunriseSunsetState

	end
