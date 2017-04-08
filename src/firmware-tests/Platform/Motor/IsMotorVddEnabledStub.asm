	#include "Platform.inc"
	#include "TestDoubles.inc"

	radix decimal

MotorRam udata
returnValue res 1

IsMotorVddEnabledStub code
	global initialiseIsMotorVddEnabledStub
	global isMotorVddEnabled

initialiseIsMotorVddEnabledStub:
	banksel returnValue
	movwf returnValue
	return

isMotorVddEnabled:
	banksel returnValue
	movf returnValue, W
	return

	end
