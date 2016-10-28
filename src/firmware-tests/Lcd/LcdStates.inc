	#ifndef __CLUCK2SESAME_TESTS_LCD_LCDSTATES_INC
	#define __CLUCK2SESAME_TESTS_LCD_LCDSTATES_INC
	#include "States.inc"
	#include "TestFixture.inc"

.assertStateIs macro expected
	.aliasLiteralForAssert expected, _a
	.assert "lcdState == _a, 'LCD state expectation failure.'"
	endm

.assertStateIsRegister macro expected
	.aliasForAssert expected, _a
	.assert "lcdState == _a, 'LCD state expectation failure.'"
	endm

	#endif
