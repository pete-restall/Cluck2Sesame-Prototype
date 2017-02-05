	#ifndef __CLUCK2SESAME_SUNRISESUNSET_SUNRISESUNSET_INC
	#define __CLUCK2SESAME_SUNRISESUNSET_SUNRISESUNSET_INC
	#include "../SunriseSunset.inc"

	extern accumulator
	extern accumulatorUpperHigh
	extern accumulatorUpperLow
	extern accumulatorLowerHigh
	extern accumulatorLowerLow
	extern coefficient
	extern coefficientHigh
	extern coefficientLow
	extern coefficientIndex

	#ifndef __CLUCK2SESAME_SUNRISESUNSET_REGISTERLOADANDANDSTORE_ASM
	extern loadCoefficientIntoAccumulator
	#endif

	#ifndef __CLUCK2SESAME_SUNRISESUNSET_COEFFICIENTS_ASM
	extern loadNextCoefficient
	#endif

	#endif
