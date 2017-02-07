	#include "Mcu.inc"

	radix decimal

	udata
	global latitudeOffset
	global longitudeOffset
	global sunriseHourBcd
	global sunriseMinuteBcd
	global sunsetHourBcd
	global sunsetMinuteBcd

	global sunriseSunsetState
	global sunriseSunsetNextState

	global accumulator
	global accumulatorUpper
	global accumulatorUpperHigh
	global accumulatorUpperLow
	global accumulatorLower
	global accumulatorLowerHigh
	global accumulatorLowerLow

	global coefficientIndex
	global coefficient
	global coefficientHigh
	global coefficientLow
	global extendedCoefficients

	global dayOfYearFractional
	global dayOfYearFractionalHigh
	global dayOfYearFractionalLow

	global numberOfCurveFittingIterations

	global curveFitAccumulator
	global curveFitAccumulatorUpper
	global curveFitAccumulatorUpperHigh
	global curveFitAccumulatorUpperLow
	global curveFitAccumulatorLower
	global curveFitAccumulatorLowerHigh
	global curveFitAccumulatorLowerLow

latitudeOffset res 1
longitudeOffset res 1
sunriseHourBcd res 1
sunriseMinuteBcd res 1
sunsetHourBcd res 1
sunsetMinuteBcd res 1

sunriseSunsetState res 1
sunriseSunsetNextState res 1

accumulator:
accumulatorUpper:
accumulatorUpperHigh res 1
accumulatorUpperLow res 1
accumulatorLower:
accumulatorLowerHigh res 1
accumulatorLowerLow res 1

coefficientIndex res 1

coefficient:
coefficientHigh res 1
coefficientLow res 1

extendedCoefficients res 1

dayOfYearFractional:
dayOfYearFractionalHigh res 1
dayOfYearFractionalLow res 1

numberOfCurveFittingIterations res 1

curveFitAccumulator:
curveFitAccumulatorUpper:
curveFitAccumulatorUpperHigh res 1
curveFitAccumulatorUpperLow res 1
curveFitAccumulatorLower:
curveFitAccumulatorLowerHigh res 1
curveFitAccumulatorLowerLow res 1

	end
