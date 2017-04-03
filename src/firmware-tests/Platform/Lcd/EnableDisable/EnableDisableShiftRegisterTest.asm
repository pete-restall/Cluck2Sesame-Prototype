	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "../../ShiftRegister/EnableDisableShiftRegisterMocks.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfEnableCalls
	global numberOfDisableCalls
	global expectedCalledEnableShiftRegisterCount
	global expectedCalledDisableShiftRegisterCount

numberOfEnableCalls res 1
numberOfDisableCalls res 1
expectedCalledEnableShiftRegisterCount res 1
expectedCalledDisableShiftRegisterCount res 1

EnableDisableShiftRegisterTest code
	global testArrange

testArrange:
	fcall initialiseEnableAndDisableShiftRegisterMocks
	fcall initialiseLcd

testAct:
	banksel numberOfEnableCalls
	movf numberOfEnableCalls
	btfsc STATUS, Z
	goto callDisableLcd

callEnableLcd:
	fcall enableLcd
	banksel numberOfEnableCalls
	decfsz numberOfEnableCalls
	goto testAct

callDisableLcd:
	banksel numberOfDisableCalls
	movf numberOfDisableCalls
	btfsc STATUS, Z
	goto testAssert

callDisableLcdInLoop:
	fcall disableLcd
	banksel numberOfDisableCalls
	decfsz numberOfDisableCalls
	goto callDisableLcdInLoop

testAssert:
	.aliasForAssert calledEnableShiftRegisterCount, _a
	.aliasForAssert expectedCalledEnableShiftRegisterCount, _b
	.assert "_a == _b, 'Expected calls to enableShiftRegister() did not match expectation.'"

	.aliasForAssert calledDisableShiftRegisterCount, _a
	.aliasForAssert expectedCalledDisableShiftRegisterCount, _b
	.assert "_a == _b, 'Expected calls to disableShiftRegister() did not match expectation.'"
	return

	end
