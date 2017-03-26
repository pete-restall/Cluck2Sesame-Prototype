	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"

	radix decimal

PwmDutyCycleFromRestTest code
	global testAct

testAct:
	fcall turnMotorClockwise
	return

	end
