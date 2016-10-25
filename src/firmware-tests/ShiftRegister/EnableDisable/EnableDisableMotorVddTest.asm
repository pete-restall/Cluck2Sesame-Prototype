	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "ShiftRegister.inc"
	#include "../EnableDisableMotorVddMocks.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfEnableCalls
	global numberOfDisableCalls
	global expectedCalledEnableMotorVddCount
	global expectedCalledDisableMotorVddCount

numberOfEnableCalls res 1
numberOfDisableCalls res 1
expectedCalledEnableMotorVddCount res 1
expectedCalledDisableMotorVddCount res 1

EnableDisableMotorVddTest code
	global testArrange

testArrange:
	fcall initialiseEnableAndDisableMotorVddMocks
	fcall initialiseShiftRegister

testAct:
	banksel numberOfEnableCalls
	movf numberOfEnableCalls
	btfsc STATUS, Z
	goto callDisableShiftRegister

callEnableShiftRegister:
	fcall enableShiftRegister
	banksel numberOfEnableCalls
	decfsz numberOfEnableCalls
	goto testAct

callDisableShiftRegister:
	banksel numberOfDisableCalls
	movf numberOfDisableCalls
	btfsc STATUS, Z
	goto testAssert

callDisableShiftRegisterInLoop:
	fcall disableShiftRegister
	banksel numberOfDisableCalls
	decfsz numberOfDisableCalls
	goto callDisableShiftRegisterInLoop

testAssert:
	.aliasForAssert calledEnableMotorVddCount, _a
	.aliasForAssert expectedCalledEnableMotorVddCount, _b
	.assert "_a == _b, 'Expected calls to enableMotorVdd() did not match expectation.'"

	.aliasForAssert calledDisableMotorVddCount, _a
	.aliasForAssert expectedCalledDisableMotorVddCount, _b
	.assert "_a == _b, 'Expected calls to disableMotorVdd() did not match expectation.'"
	return

	end
