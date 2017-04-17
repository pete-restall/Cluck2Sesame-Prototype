	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Lcd.inc"
	#include "TestFixture.inc"
	#include "../AdcMocks.inc"
	#include "../../Motor/DisableMotorVddMock.inc"
	#include "../../ShiftRegister/EnableDisableShiftRegisterMocks.inc"

	radix decimal

DisableMotorVddTest code
	global testArrange

testArrange:
	fcall initialiseAdcMocks
	fcall initialiseDisableMotorVddMock
	fcall initialiseEnableAndDisableShiftRegisterMocks
	fcall initialiseLcd

	fcall enableLcd

waitUntilLcdIsEnabled:
	fcall pollLcd
	fcall isLcdEnabled
	sublw 0
	btfsc STATUS, Z
	goto waitUntilLcdIsEnabled

testAct:
	fcall disableLcd

testAssert:
	.aliasForAssert calledDisableMotorVdd, _a
	.aliasForAssert calledDisableAdc, _b
	.assert "_a > 0 && _a > _b, 'Expected call to disableMotorVdd() after disableAdc().'"

	.aliasForAssert calledDisableMotorVdd, _a
	.aliasForAssert calledDisableShiftRegister, _b
	.assert "_a > 0 && _a < _b, 'Expected call to disableMotorVdd() before disableShiftRegister().'"
	return

	end
