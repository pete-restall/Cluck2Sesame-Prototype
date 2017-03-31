	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"

	radix decimal

SetAdcChannelFromRestIsSuccessfulTest code
	global testAct

testAct:
	fcall turnMotorAntiClockwise
	return

	end
