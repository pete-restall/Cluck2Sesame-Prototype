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
	global expectedCarry
	global expectedZero
	global carry
	global zero

expectedRBA res 1
expectedRBB res 1
expectedRBC res 1
expectedRBD res 1

expectedCarry res 1
expectedZero res 1

capturedStatus res 1
carry res 1
zero res 1

NegateBTest code
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
	fcall negateB32
	swapf STATUS, W

	banksel capturedStatus
	movwf capturedStatus
	swapf capturedStatus

	btfsc capturedStatus, C
	bsf carry, 0

	btfsc capturedStatus, Z
	bsf zero, 0

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

	banksel carry
	.assert "carry == expectedCarry, 'Carry expectation failure.'"
	.assert "zero == expectedZero, 'Zero expectation failure.'"

	return

	end
