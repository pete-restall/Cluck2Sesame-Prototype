	#include "Mcu.inc"
	#include "SunriseSunset.inc"
	#include "../Platform/Clock.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_SUNRISE_LIMITDAYOFYEAR
		banksel dayOfYearHigh
		movf dayOfYearHigh
		btfsc STATUS, Z
		goto dayOfYearLessThan256Days

dayOfYearMoreThan256Days:
		movlw low(357)
		subwf dayOfYearLow, W
		btfsc STATUS, C
		goto limitDayOfYearTo357

loadDayOfYearIntoDayOfYearFractional:
		movf dayOfYearHigh, W
		banksel dayOfYearFractionalHigh
		movwf dayOfYearFractionalHigh

		banksel dayOfYearLow
		movf dayOfYearLow, W
		banksel dayOfYearFractionalLow
		movwf dayOfYearFractionalLow
		goto setNextState

limitDayOfYearTo357:
		banksel dayOfYearFractionalHigh
		movlw high(357)
		movwf dayOfYearFractionalHigh
		movlw low(357)
		movwf dayOfYearFractionalLow
		goto setNextState

dayOfYearLessThan256Days:
		movlw 7
		subwf dayOfYearLow, W
		btfsc STATUS, C
		goto loadDayOfYearIntoDayOfYearFractional

dayOfYearLessThan7:
		goto limitDayOfYearTo357

setNextState:
		setSunriseSunsetState SUN_STATE_DAYOFYEAR
		returnFromSunriseSunsetState

	end
