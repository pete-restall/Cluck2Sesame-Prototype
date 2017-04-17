	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "Smps.inc"
	#include "TestFixture.inc"

	radix decimal

IsEnabledAfterDisabledTest code
	global testArrange

testArrange:
	fcall initialiseTimer0
	fcall initialiseSmps
	fcall disableSmps
	fcall pollSmps

	fcall enableSmps

waitUntilSmpsIsEnabled:
	fcall pollSmps
	fcall isSmpsEnabled
	xorlw 0
	btfsc STATUS, Z
	goto waitUntilSmpsIsEnabled

testAct:
	fcall disableSmps
	fcall pollSmps

testAssert:
	fcall isSmpsEnabled
	.aliasWForAssert _a
	.assert "_a == 0, 'Expected SMPS to be disabled.'"
	return

	end
