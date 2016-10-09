	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Arithmetic32.inc"
	#include "TestFixture.inc"
	radix decimal

	udata
	global expectedRAA
	global expectedRAB
	global expectedRAC
	global expectedRAD
	global expectedRBA
	global expectedRBB
	global expectedRBC
	global expectedRBD
	global expectedCarry
	global expectedZero
	global carry
	global digitCarry
	global zero

expectedRAA res 1
expectedRAB res 1
expectedRAC res 1
expectedRAD res 1

expectedRBA res 1
expectedRBB res 1
expectedRBC res 1
expectedRBD res 1

expectedCarry res 1
expectedZero res 1

capturedStatus res 1
carry res 1
digitCarry res 1
zero res 1

AddTest code
	global testArrange

testArrange:
	banksel carry
	clrf carry
	clrf digitCarry
	clrf zero

testAct:
	fcall add32
	swapf STATUS, W

	banksel capturedStatus
	movwf capturedStatus
	swapf capturedStatus

	btfsc capturedStatus, C
	bsf carry, 0

	btfsc capturedStatus, DC
	bsf digitCarry, 0

	btfsc capturedStatus, Z
	bsf zero, 0

testAssert:
	.assert "RAA == expectedRAA, 'RAA expectation failure.'"
	.assert "RAB == expectedRAB, 'RAB expectation failure.'"
	.assert "RAC == expectedRAC, 'RAC expectation failure.'"
	.assert "RAD == expectedRAD, 'RAD expectation failure.'"

	.assert "RBA == expectedRBA, 'RBA expectation failure.'"
	.assert "RBB == expectedRBB, 'RBB expectation failure.'"
	.assert "RBC == expectedRBC, 'RBC expectation failure.'"
	.assert "RBD == expectedRBD, 'RBD expectation failure.'"

	.assert "carry == expectedCarry, 'Carry expectation failure.'"
	.assert "zero == expectedZero, 'Zero expectation failure.'"

	.done

	end
