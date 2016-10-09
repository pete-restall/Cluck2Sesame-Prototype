	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "TestFixture.inc"
	radix decimal

	udata
	global initialW
	global expectedW
	global expectedCarry
	global expectedZero
	global carry
	global zero

initialW res 1
expectedW res 1
expectedCarry res 1
expectedZero res 1

capturedW res 1
capturedStatus res 1
carry res 1
zero res 1

IncrementTest code
	global testArrange

testArrange:
	banksel carry
	clrf carry
	clrf zero

testAct:
	movf initialW, W
	fcall incBcd

	banksel capturedW
	movwf capturedW
	swapf STATUS, W

	movwf capturedStatus
	swapf capturedStatus

	btfsc capturedStatus, C
	bsf carry, 0

	btfsc capturedStatus, Z
	bsf zero, 0

testAssert:
	.assert "capturedW == expectedW, 'W expectation failure.'"
	.assert "carry == expectedCarry, 'Carry expectation failure.'"
	.assert "zero == expectedZero, 'Zero expectation failure.'"

	.done

	end
