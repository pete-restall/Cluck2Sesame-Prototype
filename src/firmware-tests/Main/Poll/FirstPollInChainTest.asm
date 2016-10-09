	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TemperatureSensor.inc"
	#include "TestFixture.inc"
	radix decimal

	extern pollForWork

	global pollForWorkAddressHigh
	global pollForWorkAddressLow
	global pollTemperatureSensorAddressHigh
	global pollTemperatureSensorAddressLow

	udata
pollForWorkAddressHigh res 1
pollForWorkAddressLow res 1
pollTemperatureSensorAddressHigh res 1
pollTemperatureSensorAddressLow res 1

FirstPollInChainTest code
	global testArrange

testArrange:
storePollForWorkAddressHigh:
	banksel pollForWorkAddressHigh
	movlw high pollForWork
	movwf pollForWorkAddressHigh

storePollForWorkAddressLow:
	banksel pollForWorkAddressLow
	movlw low pollForWork
	movwf pollForWorkAddressLow

storePollTemperatureSensorAddressHigh:
	banksel pollTemperatureSensorAddressHigh
	movlw high pollTemperatureSensor
	movwf pollTemperatureSensorAddressHigh

storePollTemperatureSensorAddressLow:
	banksel pollTemperatureSensorAddressLow
	movlw low pollTemperatureSensor
	movwf pollTemperatureSensorAddressLow

testAct:
	pagesel testArrange

testAssert:
	.assert "pollForWorkAddressHigh == pollTemperatureSensorAddressHigh, 'Expected first poll in chain to be pollTemperatureSensor.'"
	.assert "pollForWorkAddressLow == pollTemperatureSensorAddressLow, 'Expected first poll in chain to be pollTemperatureSensor.'"

	.done

	end
