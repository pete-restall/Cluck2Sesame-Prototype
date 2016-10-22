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
	global isMotorVddEnabled

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

isMotorVddEnabled:
	; TODO: MOCK RECORDING WHAT ?  REQUIRED TO PASS THE BUILD AT THE MOMENT, NOTHING MORE...
	return

	end
