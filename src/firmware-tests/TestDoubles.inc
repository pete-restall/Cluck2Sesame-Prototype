	#ifndef __CLUCK2SESAME_TESTS_TESTDOUBLES_INC
	#define __CLUCK2SESAME_TESTS_TESTDOUBLES_INC

	extern initialiseTestDoubles

	extern mockCallCounter

mockCalled macro counter
	banksel mockCallCounter
	incf mockCallCounter
	movf mockCallCounter, W

	banksel counter
	movwf counter
	endm

	#endif
