	#include "Mcu.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_CALCULATESUNRISE
loadFirstCoefficientIntoAccumulator:
		banksel coefficientIndex
		clrf coefficientIndex
		call loadNextCoefficient
		call loadCoefficientIntoAccumulator

	; SET NEXT STATE...BUT THEN WHAT IS THAT NEXT STATE ?  MAYBE LOADING THE SECON ACCUMULATOR.  ALSO NEED TO SET A 'NEXT STATE', TOO, WHICH WILL BE FOR CALCULATING THE LATITUDE ADJUSTMENT...

		returnFromSunriseSunsetState

	end
