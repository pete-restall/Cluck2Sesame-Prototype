	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global expectedRAA
	global expectedRAB
	global expectedRAC
	global expectedRAD

expectedRAA res 1
expectedRAB res 1
expectedRAC res 1
expectedRAD res 1

SignExtendToUpperWordATest code
	global testArrange

testArrange:

testAct:
	fcall signExtendToUpperWordA32

testAssert:
	.aliasForAssert RAA, _a
	.aliasForAssert expectedRAA, _b
	.assert "_a == _b, 'RAA expectation failure.'"

	.aliasForAssert RAB, _a
	.aliasForAssert expectedRAB, _b
	.assert "_a == _b, 'RAB expectation failure.'"

	.aliasForAssert RAC, _a
	.aliasForAssert expectedRAC, _b
	.assert "_a == _b, 'RAC expectation failure.'"

	.aliasForAssert RAD, _a
	.aliasForAssert expectedRAD, _b
	.assert "_a == _b, 'RAD expectation failure.'"

	return

	end
