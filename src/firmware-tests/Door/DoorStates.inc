	#ifndef __CLUCK2SESAME_TESTS_DOOR_DOORSTATES_INC
	#define __CLUCK2SESAME_TESTS_DOOR_DOORSTATES_INC
	#include "TestFixture.inc"
	#include "States.inc"

.assertStateIs macro expected
	.aliasForAssert doorState, _a
	.aliasLiteralForAssert expected, _b
	.assert "_a == _b, 'Door state expectation failure.'"
	endm

.assertStateIsRegister macro expected
	.aliasForAssert doorState, _a
	.aliasForAssert expected, _b
	.assert "_a == _b, 'Door state expectation failure.'"
	endm

	#endif
