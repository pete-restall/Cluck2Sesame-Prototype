	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	radix decimal

	extern main

	global testArrange
	global pollCount
	global pollTemperatureSensor

NUMBER_OF_ITERATIONS equ 10

	udata
pollCount res 1

	code
testArrange:
	banksel pollCount
	movlw NUMBER_OF_ITERATIONS
	movwf pollCount

testAct:
	fcall main

testAssert:
	.assert "pollCount == 0, \"Main did not call pollTemperatureSensor repeatedly.\""
	.done

pollTemperatureSensor:
	banksel pollCount
	decfsz pollCount
	return
	goto testAssert

	end
