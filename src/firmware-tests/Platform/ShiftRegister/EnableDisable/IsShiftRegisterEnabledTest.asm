	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "ShiftRegister.inc"
	#include "../../Smps/IsSmpsEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global isSmpsEnabledStubbedValue
	global numberOfEnableCalls
	global numberOfDisableCalls
	global expectedIsShiftRegisterEnabled

isSmpsEnabledStubbedValue res 1
numberOfEnableCalls res 1
numberOfDisableCalls res 1
expectedIsShiftRegisterEnabled res 1

IsShiftRegisterEnabledTest code
	global testArrange

testArrange:
	fcall initialiseShiftRegister

stubIsSmpsEnabled:
	banksel isSmpsEnabledStubbedValue
	movf isSmpsEnabledStubbedValue, W
	fcall initialiseIsSmpsEnabledStub

callEnableTheSpecifiedNumberOfTimes:
	banksel numberOfEnableCalls
	movf numberOfEnableCalls
	btfsc STATUS, Z
	goto callDisableShiftRegister

callEnableShiftRegister:
	fcall enableShiftRegister
	banksel numberOfEnableCalls
	decfsz numberOfEnableCalls
	goto callEnableShiftRegister

callDisableShiftRegister:
	banksel numberOfDisableCalls
	movf numberOfDisableCalls
	btfsc STATUS, Z
	goto testAct

callDisableShiftRegisterInLoop:
	fcall disableShiftRegister
	banksel numberOfDisableCalls
	decfsz numberOfDisableCalls
	goto callDisableShiftRegisterInLoop

testAct:
	fcall isShiftRegisterEnabled

testAssert:
	.aliasWForAssert _a
	banksel expectedIsShiftRegisterEnabled
	movf expectedIsShiftRegisterEnabled
	btfss STATUS, Z
	goto assertShiftRegisterIsEnabled

assertShiftRegisterIsDisabled:
	.assert "_a == 0, 'Expected isShiftRegisterEnabled() to return false.'"
	return

assertShiftRegisterIsEnabled:
	.assert "_a != 0, 'Expected isShiftRegisterEnabled() to return true.'"

	end
