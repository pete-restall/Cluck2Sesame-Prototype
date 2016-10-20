	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../EnableDisableSmpsMocks.inc"
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
	fcall initialiseMotor

testAct:
	banksel numberOfEnableCalls
	movf numberOfEnableCalls
	btfsc STATUS, Z
	goto callDisableMotorVdd

callEnableMotorVdd:
	fcall enableMotorVdd
	banksel numberOfEnableCalls
	decfsz numberOfEnableCalls
	goto testAct

callDisableMotorVdd:
	banksel numberOfDisableCalls
	movf numberOfDisableCalls
	btfsc STATUS, Z
	goto testAssert

callDisableMotorVddInLoop:
	fcall disableMotorVdd
	banksel numberOfDisableCalls
	decfsz numberOfDisableCalls
	goto callDisableMotorVddInLoop

testAssert:
	.assert "calledEnableSmpsCount == expectedCalledEnableSmpsCount, 'Expected calls to smpsEnable() did not match expectation.'"
	.assert "calledDisableSmpsCount == expectedCalledDisableSmpsCount, 'Expected calls to smpsDisable() did not match expectation.'"
	return

	end
