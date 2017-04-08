	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global expectedRAA
	global expectedW
	global expectedZero
	global expectedCarry
	global zero
	global carry

expectedRAA res 1
expectedW res 1
expectedZero res 1
expectedCarry res 1

capturedW res 1
capturedStatus res 1
zero res 1
carry res 1

FromBinaryTest code
	global testArrange

testArrange:
	banksel zero
	clrf zero
	clrf carry

testAct:
	fcall binaryToBcd

	banksel capturedW
	movwf capturedW

	swapf STATUS, W
	movwf capturedStatus
	swapf capturedStatus

	btfsc capturedStatus, Z
	bsf zero, 0

	btfsc capturedStatus, C
	bsf carry, 0

testAssert:
	.aliasForAssert RAA, _a
	.aliasForAssert expectedRAA, _b
	.assert "_a == _b, 'RAA expectation failure.'"

	banksel capturedW
	.assert "capturedW == expectedW, 'W expectation failure.'"
	.assert "zero == expectedZero, 'Zero expectation failure.'"
	.assert "carry == expectedCarry, 'Carry expectation failure.'"
	return

	end
