	#ifndef __CLUCK2SESAME_TESTS_PLATFORM_LCD_LCDSTATES_INC
	#define __CLUCK2SESAME_TESTS_PLATFORM_LCD_LCDSTATES_INC
	#include "TestFixture.inc"
	#include "States.inc"

.assertStateIs macro expected
	.aliasForAssert lcdState, _a
	.aliasLiteralForAssert expected, _b
	.assert "_a == _b, 'LCD state expectation failure.'"
	endm

.assertStateIsRegister macro expected
	.aliasForAssert lcdState, _a
	.aliasForAssert expected, _b
	.assert "_a == _b, 'LCD state expectation failure.'"
	endm

	#endif
