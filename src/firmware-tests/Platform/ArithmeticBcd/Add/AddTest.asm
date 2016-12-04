	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global expectedRAA
	global expectedRBA
	global expectedCarry
	global expectedZero
	global carry
	global zero

expectedRAA res 1
expectedRBA res 1

expectedCarry res 1
expectedZero res 1

capturedStatus res 1
carry res 1
zero res 1

AddTest code
	global testArrange

testArrange:
	banksel carry
	clrf carry
	clrf zero

testAct:
	fcall addBcd
	swapf STATUS, W

	banksel capturedStatus
	movwf capturedStatus
	swapf capturedStatus

	btfsc capturedStatus, C
	bsf carry, 0

	btfsc capturedStatus, Z
	bsf zero, 0

testAssert:
	.aliasForAssert RAA, _a
	.aliasForAssert expectedRAA, _b
	.assert "_a == _b, 'RAA expectation failure.'"

	.aliasForAssert RBA, _a
	.aliasForAssert expectedRBA, _b
	.assert "_a == _b, 'RBA expectation failure.'"

	banksel carry
	.assert "carry == expectedCarry, 'Carry expectation failure.'"
	.assert "zero == expectedZero, 'Zero expectation failure.'"
	return

	end
