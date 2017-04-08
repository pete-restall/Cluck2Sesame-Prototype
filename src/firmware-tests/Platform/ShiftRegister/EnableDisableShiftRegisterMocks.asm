	#include "Platform.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledEnableShiftRegisterCount
	global calledDisableShiftRegisterCount

calledEnableShiftRegisterCount res 1
calledDisableShiftRegisterCount res 1

EnableDisableShiftRegisterMocks code
	global initialiseEnableAndDisableShiftRegisterMocks
	global enableShiftRegister
	global disableShiftRegister
	global isShiftRegisterEnabled

initialiseEnableAndDisableShiftRegisterMocks:
	banksel calledEnableShiftRegisterCount
	clrf calledEnableShiftRegisterCount
	clrf calledDisableShiftRegisterCount
	return

enableShiftRegister:
	mockIncrementCallCounter calledEnableShiftRegisterCount
	return

disableShiftRegister:
	mockIncrementCallCounter calledDisableShiftRegisterCount
	return

isShiftRegisterEnabled:
	; TODO: MOCK RECORDING WHAT ?  REQUIRED TO PASS THE BUILD AT THE MOMENT, NOTHING MORE...
	return

	end
