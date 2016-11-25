	#include "p16f685.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledEnableMotorVddCount
	global calledDisableMotorVddCount
	global calledIsMotorVddEnabledCount

calledEnableMotorVddCount res 1
calledDisableMotorVddCount res 1
calledIsMotorVddEnabledCount res 1

EnableDisableMotorVddMocks code
	global initialiseEnableAndDisableMotorVddMocks
	global enableMotorVdd
	global disableMotorVdd
	global isMotorVddEnabled

initialiseEnableAndDisableMotorVddMocks:
	banksel calledEnableMotorVddCount
	clrf calledEnableMotorVddCount
	clrf calledDisableMotorVddCount
	clrf calledIsMotorVddEnabledCount
	return

enableMotorVdd:
	mockIncrementCallCounter calledEnableMotorVddCount
	return

disableMotorVdd:
	mockIncrementCallCounter calledDisableMotorVddCount
	return

isMotorVddEnabled:
	mockIncrementCallCounter calledIsMotorVddEnabledCount
	retlw 0

	end
