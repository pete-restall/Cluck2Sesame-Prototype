	#include "Mcu.inc"
	#include "SunriseSunset.inc"
	#include "../Platform/Clock.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNSET_LIMITDAYOFYEAR
		banksel dayOfYearHigh
		movf dayOfYearHigh, W
		banksel dayOfYearFractionalHigh
		movwf dayOfYearFractionalHigh
		banksel dayOfYearLow
		movf dayOfYearLow, W
		banksel dayOfYearFractionalLow
		movwf dayOfYearFractionalLow

setNextState:
		setSunriseSunsetState SUN_STATE_DAYOFYEAR
		returnFromSunriseSunsetState

	end
