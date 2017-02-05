	#define __CLUCK2SESAME_SUNRISESUNSET_REGISTERLOADANDANDSTORE_ASM

	#include "Mcu.inc"
	#include "SunriseSunset.inc"

	radix decimal

SunriseSunset code
	global loadCoefficientIntoAccumulator

loadCoefficientIntoAccumulator:
	banksel accumulator
	clrf accumulatorUpperHigh
	clrf accumulatorUpperLow
	movf coefficientHigh, W
	movwf accumulatorLowerHigh
	movf coefficientLow, W
	movwf accumulatorLowerLow
	return

	end
