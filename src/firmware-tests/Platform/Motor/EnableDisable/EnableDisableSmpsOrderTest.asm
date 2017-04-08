	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../../Smps/EnableDisableSmpsMocks.inc"
	#include "TestFixture.inc"

	radix decimal

EnableDisableSmpsOrderTest code
	global testArrange

testArrange:
	fcall initialiseEnableAndDisableSmpsMocks
	fcall initialiseMotor

testAct:
	fcall enableMotorVdd
	fcall disableMotorVdd

testAssert:
	movlw 1 << TRISC6
	banksel calledEnableSmpsTrisc

	andwf calledEnableSmpsTrisc
	.assert "(calledEnableSmpsTrisc & 0xff) != 0, 'Expected MOTOR_VDD_EN to be disabled when enableSmps() called.'"

	andwf calledDisableSmpsTrisc
	.assert "(calledDisableSmpsTrisc & 0xff) != 0, 'Expected MOTOR_VDD_EN to be disabled when disableSmps() called.'"
	return

	end
