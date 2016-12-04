	#include "Mcu.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledEnableMotorVdd

calledEnableMotorVdd res 1

InitialiseEnableMotorVddMock code
	global initialiseEnableMotorVddMock
	global enableMotorVdd

initialiseEnableMotorVddMock:
	banksel calledEnableMotorVdd
	clrf calledEnableMotorVdd
	return

enableMotorVdd:
	mockCalled calledEnableMotorVdd
	return

	end
