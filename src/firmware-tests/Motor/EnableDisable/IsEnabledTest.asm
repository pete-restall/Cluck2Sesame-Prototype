	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "../IsSmpsEnabledStub.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global stubIsSmpsEnabled
	global expectedIsMotorVddEnabled

stubIsSmpsEnabled res 1
expectedIsMotorVddEnabled res 1

IsEnabledTest code
	global testArrange

testArrange:
	banksel stubIsSmpsEnabled
	movf stubIsSmpsEnabled, W
	fcall initialiseIsSmpsEnabledStub

testAct:
	movlw 0
	fcall isMotorVddEnabled

testAssert:
	.assert "W == expectedIsMotorVddEnabled, 'Expectation failure for isMotorVddEnabled().'"
	return

	end
