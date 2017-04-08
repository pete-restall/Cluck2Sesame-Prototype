	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "TestFixture.inc"

	radix decimal

ReadFlashWordTest code
	global testArrange

testArrange:

testAct:
	loadFlashAddressOf magicWord
	fcall readFlashWord

testAssert:
	.aliasForAssert EEDAT, _a
	.assert "_a == 0x79, 'Expected EEDAT == 0x79.'"

	.aliasForAssert EEDATH, _a
	.assert "_a == 0x35, 'Expected EEDATH == 0x35.'"
	return

magicWord dw 0x3579

	end
