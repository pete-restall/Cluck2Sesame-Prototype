	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "../Platform/Arithmetic32.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_DAYOFYEAR
loadDividendAsDayOfYearShiftedLeftFifteenPlaces:
loadAsShiftedLeftSixteenPlaces:
		banksel dayOfYearFractionalHigh
		movf dayOfYearFractionalHigh, W
		banksel RAA
		movwf RAA

		banksel dayOfYearFractionalLow
		movf dayOfYearFractionalLow, W
		banksel RAB
		movwf RAB
		clrf RAC
		clrf RAD

shiftRightOnePlace:
		bcf STATUS, C
		rrf RAA
		rrf RAB
		rrf RAC

loadDivisorAsNumberOfDaysInLeapYear:
		movlw high(366)
		movwf RBC
		movlw low(366)
		movwf RBD

divideAndStoreAsDayOfYearFractional:
		fcall div32x16
		movf RAC, W
		banksel dayOfYearFractionalHigh
		movwf dayOfYearFractionalHigh
		banksel RAD
		movf RAD, W
		banksel dayOfYearFractionalLow
		movwf dayOfYearFractionalLow

		setSunriseSunsetState SUN_STATE_CURVEFIT1
		returnFromSunriseSunsetState

	end
