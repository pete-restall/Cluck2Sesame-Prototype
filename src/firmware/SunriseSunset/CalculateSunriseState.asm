	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_CALCULATESUNRISE
		movf sunriseAdjustmentMinutes, W
		movwf adjustmentMinutes

		setSunriseSunsetState SUN_STATE_SUNRISE_LOADLOOKUPS

		call loadDayOfYearIntoA
		call loadLookupStepIntoLowerB
		fcall div32x16
		call storeLookupIndexFromA
		returnFromSunriseSunsetState

	end
