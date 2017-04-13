	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"
	#include "TestFixture.inc"

	radix decimal

FlagsTest code
	global testArrange

testArrange:

testAct:
	fcall initialiseMotor

testAssert:
	banksel motorFlags
	.aliasLiteralForAssert (1 << MOTOR_FLAG_PREVENT_OVERLOAD), _b
	.assert "motorFlags == _b, 'Expected motorFlags to be MOTOR_FLAG_PREVENT_OVERLOAD.'"
	return

	end
