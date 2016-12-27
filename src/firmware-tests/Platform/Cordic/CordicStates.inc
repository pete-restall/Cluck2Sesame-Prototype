	#ifndef __CLUCK2SESAME_TESTS_PLATFORM_CORDIC_CORDICSTATES_INC
	#define __CLUCK2SESAME_TESTS_PLATFORM_CORDIC_CORDICSTATES_INC
	#include "TestFixture.inc"
	#include "States.inc"

.assertStateIs macro expected
	.aliasForAssert cordicState, _a
	.aliasLiteralForAssert expected, _b
	.assert "_a == _b, 'CORDIC state expectation failure.'"
	endm

.assertStateIsRegister macro expected
	.aliasForAssert cordicState, _a
	.aliasForAssert expected, _b
	.assert "_a == _b, 'CORDIC state expectation failure.'"
	endm

	#endif
