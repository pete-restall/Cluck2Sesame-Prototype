	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global expectedRBA
	global expectedRBB
	global expectedRBC
	global expectedRBD

expectedRBA res 1
expectedRBB res 1
expectedRBC res 1
expectedRBD res 1

SignExtendToUpperWordBTest code
	global testArrange

testArrange:

testAct:
	fcall signExtendToUpperWordB32

testAssert:
	.aliasForAssert RBA, _a
	.aliasForAssert expectedRBA, _b
	.assert "_a == _b, 'RBA expectation failure.'"

	.aliasForAssert RBB, _a
	.aliasForAssert expectedRBB, _b
	.assert "_a == _b, 'RBB expectation failure.'"

	.aliasForAssert RBC, _a
	.aliasForAssert expectedRBC, _b
	.assert "_a == _b, 'RBC expectation failure.'"

	.aliasForAssert RBD, _a
	.aliasForAssert expectedRBD, _b
	.assert "_a == _b, 'RBD expectation failure.'"

	return

	end
