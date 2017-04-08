	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Buttons.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialIocb

initialIocb res 1

InterruptOnChangeTest code
	global testArrange

testArrange:
	banksel initialIocb
	movf initialIocb, W
	banksel IOCB
	movwf IOCB

testAct:
	fcall initialiseButtons

testAssert:
	banksel initialIocb
	movlw (1 << IOCB5) | (1 << IOCB6)
	iorwf initialIocb

	.aliasForAssert IOCB, _a
	.aliasForAssert initialIocb, _b
	.assert "_a == _b, 'IOCB expectation failure.'"

	return

	end
