	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global numberOfEnableCalls
	global numberOfDisableCalls
	global initialT2con
	global expectedT2con

numberOfEnableCalls res 1
numberOfDisableCalls res 1
initialT2con res 1
expectedT2con res 1

Timer2Test code
	global testArrange

testArrange:
	fcall initialiseMotor

	banksel initialT2con
	movf initialT2con, W
	banksel T2CON
	movwf T2CON

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
	.aliasForAssert T2CON, _a
	.aliasForAssert expectedT2con, _b
	.assert "_a == _b, 'T2CON expectation mismatch.'"
	return

	end
