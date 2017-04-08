	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"

	radix decimal

PreConditionsFromRestAreUnsuccessfulTest code
	global testAct

testAct:
	fcall turnMotorAntiClockwise
	return

	end
