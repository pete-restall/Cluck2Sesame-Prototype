	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"

	radix decimal

PwmDutyCycleFromRestTest code
	global testAct

testAct:
	fcall turnMotorAntiClockwise
	return

	end
