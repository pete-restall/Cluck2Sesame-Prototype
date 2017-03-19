	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "Clock.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_CALCULATESUNSET
		call loadDayOfYearIntoA
		call loadLookupStepIntoLowerB
		fcall div32x16

		setupIndf RAA
		loadFromIndf32Into lookupIndex

		setSunriseSunsetState SUN_STATE_SUNSET_LOADLOOKUPS
		returnFromSunriseSunsetState

	end
