	#include "Mcu.inc"
	#include "SunriseSunset.inc"
	#include "States.inc"

	radix decimal

	defineSunriseSunsetState SUN_STATE_CALCULATESUNSET
loadFirstCoefficientIntoAccumulator:
		banksel coefficientIndex
		movlw SUNSET_REFERENCE_COEFFICIENT_INDEX
		movwf coefficientIndex
		call loadNextCoefficient
		call loadCoefficientIntoAccumulator

loadExtendedCoefficients:
		call loadSunsetReferenceExtendedCoefficients

setNumberOfFittingIterationsAndNextState:
		banksel numberOfCurveFittingIterations
		movlw 3
		movwf numberOfCurveFittingIterations

		setSunriseSunsetNextState SUN_STATE_SUNSET_LATITUDEADJUSTMENT
		setSunriseSunsetState SUN_STATE_SUNSET_LIMITDAYOFYEAR
		returnFromSunriseSunsetState

	end
