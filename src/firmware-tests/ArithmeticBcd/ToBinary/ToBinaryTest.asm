	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global expectedRAA
	global expectedW
	global expectedZero
	global zero

expectedRAA res 1
expectedW res 1
expectedZero res 1

capturedW res 1
capturedStatus res 1
zero res 1

ToBinaryTest code
	global testArrange

testArrange:
	banksel zero
	clrf zero

testAct:
	fcall bcdToBinary

	banksel capturedW
	movwf capturedW

	swapf STATUS, W
	movwf capturedStatus
	swapf capturedStatus

	btfsc capturedStatus, Z
	bsf zero, 0

	movf capturedW, W

testAssert:
	.assert "RAA == expectedRAA, 'RAA expectation failure.'"
	.assert "W == expectedW, 'W expectation failure.'"
	.assert "zero == expectedZero, 'Zero expectation failure.'"
	return

	end
