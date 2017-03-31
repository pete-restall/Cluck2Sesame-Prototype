	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"

	radix decimal

SetAdcChannelFromRestIsUnsuccessfulTest code
	global testAct

testAct:
	fcall turnMotorAntiClockwise
	return

	end
