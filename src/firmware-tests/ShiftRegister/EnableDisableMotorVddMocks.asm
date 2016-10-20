	#include "p16f685.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledEnableMotorVddCount
	global calledDisableMotorVddCount

calledEnableMotorVddCount res 1
calledDisableMotorVddCount res 1

EnableDisableMotorVdd code
	global initialiseEnableAndDisableMotorVddMocks
	global enableMotorVdd
	global disableMotorVdd

initialiseEnableAndDisableMotorVddMocks:
	banksel calledEnableMotorVddCount
	clrf calledEnableMotorVddCount
	clrf calledDisableMotorVddCount
	return

enableMotorVdd:
	mockIncrementCallCounter calledEnableMotorVddCount
	return

disableMotorVdd:
	mockIncrementCallCounter calledDisableMotorVddCount
	return

	end
