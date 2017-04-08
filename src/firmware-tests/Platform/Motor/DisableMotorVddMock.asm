	#include "Platform.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledDisableMotorVdd

calledDisableMotorVdd res 1

InitialiseDisableMotorVddMock code
	global initialiseDisableMotorVddMock
	global disableMotorVdd

initialiseDisableMotorVddMock:
	banksel calledDisableMotorVdd
	clrf calledDisableMotorVdd
	return

disableMotorVdd:
	mockCalled calledDisableMotorVdd
	return

	end
