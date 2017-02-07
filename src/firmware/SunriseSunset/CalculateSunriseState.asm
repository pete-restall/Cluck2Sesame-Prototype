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

loadExtendedCoefficients:
		call loadSunriseReferenceExtendedCoefficients

setNumberOfFittingIterationsAndNextState:
		banksel numberOfCurveFittingIterations
		movlw 3
		movwf numberOfCurveFittingIterations

		setSunriseSunsetNextState SUN_STATE_SUNRISE_LATITUDEADJUSTMENT
		setSunriseSunsetState SUN_STATE_SUNRISE_LIMITDAYOFYEAR
		returnFromSunriseSunsetState

	end
