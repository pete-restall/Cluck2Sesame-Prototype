	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "ShiftRegister.inc"
	#include "../../Smps/EnableDisableSmpsMocks.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfEnableCalls
	global numberOfDisableCalls
	global expectedCalledEnableSmpsCount
	global expectedCalledDisableSmpsCount

numberOfEnableCalls res 1
numberOfDisableCalls res 1
expectedCalledEnableSmpsCount res 1
expectedCalledDisableSmpsCount res 1

EnableDisableSmpsTest code
	global testArrange

testArrange:
	fcall initialiseEnableAndDisableSmpsMocks
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
	goto callEnableShiftRegister

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
	.aliasForAssert calledEnableSmpsCount, _a
	.aliasForAssert expectedCalledEnableSmpsCount, _b
	.assert "_a == _b, 'Expected calls to enableSmps() did not match expectation.'"

	.aliasForAssert calledDisableSmpsCount, _a
	.aliasForAssert expectedCalledDisableSmpsCount, _b
	.assert "_a == _b, 'Expected calls to disableSmps() did not match expectation.'"
	return

	end
