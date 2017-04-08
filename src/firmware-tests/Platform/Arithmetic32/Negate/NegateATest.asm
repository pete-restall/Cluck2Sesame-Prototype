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
	global expectedCarry
	global expectedZero
	global carry
	global zero

expectedRAA res 1
expectedRAB res 1
expectedRAC res 1
expectedRAD res 1

expectedCarry res 1
expectedZero res 1

capturedStatus res 1
carry res 1
zero res 1

NegateATest code
	global testArrange

testArrange:
	banksel carry
	clrf carry
	clrf zero

setCarryToOppositeOfExpected:
	movlw 0xff
	andwf expectedCarry, W
	bcf STATUS, C
	btfsc STATUS, Z
	bsf STATUS, C

setZeroToOppositeOfExpected:
	movlw 0xff
	andwf expectedZero, W

testAct:
	fcall negateA32
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

	.aliasForAssert RAB, _a
	.aliasForAssert expectedRAB, _b
	.assert "_a == _b, 'RAB expectation failure.'"

	.aliasForAssert RAC, _a
	.aliasForAssert expectedRAC, _b
	.assert "_a == _b, 'RAC expectation failure.'"

	.aliasForAssert RAD, _a
	.aliasForAssert expectedRAD, _b
	.assert "_a == _b, 'RAD expectation failure.'"

	banksel carry
	.assert "carry == expectedCarry, 'Carry expectation failure.'"
	.assert "zero == expectedZero, 'Zero expectation failure.'"

	return

	end
