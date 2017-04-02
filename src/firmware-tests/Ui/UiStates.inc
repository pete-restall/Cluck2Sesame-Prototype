	#ifndef __CLUCK2SESAME_TESTS_UI_UISTATES_INC
	#define __CLUCK2SESAME_TESTS_UI_UISTATES_INC
	#include "TestFixture.inc"
	#include "States.inc"
	#include "WaitButtonPressState.inc"

.assertStateIs macro expected
	.aliasForAssert uiState, _a
	.aliasLiteralForAssert expected, _b
	.assert "_a == _b, 'UI state expectation failure.'"
	endm

.assertStateIsRegister macro expected
	.aliasForAssert uiState, _a
	.aliasForAssert expected, _b
	.assert "_a == _b, 'UI state expectation failure.'"
	endm

	#endif
