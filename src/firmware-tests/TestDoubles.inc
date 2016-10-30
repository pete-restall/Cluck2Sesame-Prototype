	#ifndef __CLUCK2SESAME_TESTS_TESTDOUBLES_INC
	#define __CLUCK2SESAME_TESTS_TESTDOUBLES_INC

	extern initialiseTestDoubles

	extern mockCallCounter

loadNonZeroIncrementedMockCallCounterInW macro
	banksel mockCallCounter
	incf mockCallCounter
	btfsc STATUS, Z
	incf mockCallCounter
	movf mockCallCounter, W
	endm

mockCalled macro counter
	loadNonZeroIncrementedMockCallCounterInW

	banksel counter
	movwf counter
	endm

mockIncrementCallCounter macro counter
	banksel counter
	incf counter
	endm

	#endif
