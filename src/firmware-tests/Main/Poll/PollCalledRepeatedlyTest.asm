	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"

	radix decimal

	extern main

	global pollCount
NUMBER_OF_ITERATIONS equ 10

	udata
pollCount res 1

PollCalledRepeatedlyTest code
	global testArrange
	global pollForWork

testArrange:
	banksel pollCount
	movlw NUMBER_OF_ITERATIONS
	movwf pollCount

testAct:
	fcall main

testAssert:
	.assert "pollCount == 0, 'Main did not call pollForWork repeatedly.'"
	.done

pollForWork:
	banksel pollCount
	decfsz pollCount
	return
	goto testAssert

	end
