	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../../Smps/IsSmpsEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global stubIsSmpsEnabled
	global numberOfEnableCalls
	global numberOfDisableCalls
	global expectedIsMotorVddEnabled

stubIsSmpsEnabled res 1
numberOfEnableCalls res 1
numberOfDisableCalls res 1
expectedIsMotorVddEnabled res 1

IsEnabledTest code
	global testArrange

testArrange:
	banksel stubIsSmpsEnabled
	movf stubIsSmpsEnabled, W
	fcall initialiseIsSmpsEnabledStub

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
	goto callIsMotorVddEnabled

callDisableMotorVddInLoop:
	fcall disableMotorVdd
	banksel numberOfDisableCalls
	decfsz numberOfDisableCalls
	goto callDisableMotorVddInLoop

callIsMotorVddEnabled:
	fcall isMotorVddEnabled

testAssert:
	banksel expectedIsMotorVddEnabled
	movf expectedIsMotorVddEnabled
	btfss STATUS, Z
	goto testAssertForMotorVddEnabled

testAssertForMotorVddDisabled:
	.assert "W == 0, 'Expected that isMotorVddEnabled() is false.'"
	return

testAssertForMotorVddEnabled:
	.assert "W != 0, 'Expected that isMotorVddEnabled() is true.'"
	return

	end
