	#include "Platform.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledEnableShiftRegister
	global calledEnableShiftRegisterCount
	global calledDisableShiftRegister
	global calledDisableShiftRegisterCount

calledEnableShiftRegister res 1
calledEnableShiftRegisterCount res 1
calledDisableShiftRegister res 1
calledDisableShiftRegisterCount res 1

EnableDisableShiftRegisterMocks code
	global initialiseEnableAndDisableShiftRegisterMocks
	global enableShiftRegister
	global disableShiftRegister
	global isShiftRegisterEnabled

initialiseEnableAndDisableShiftRegisterMocks:
	banksel calledEnableShiftRegister
	clrf calledEnableShiftRegister
	clrf calledEnableShiftRegisterCount
	clrf calledDisableShiftRegister
	clrf calledDisableShiftRegisterCount
	return

enableShiftRegister:
	mockCalled calledEnableShiftRegister
	mockIncrementCallCounter calledEnableShiftRegisterCount
	return

disableShiftRegister:
	mockCalled calledDisableShiftRegister
	mockIncrementCallCounter calledDisableShiftRegisterCount
	return

isShiftRegisterEnabled:
	; TODO: MOCK RECORDING WHAT ?  REQUIRED TO PASS THE BUILD AT THE MOMENT, NOTHING MORE...
	return

	end
