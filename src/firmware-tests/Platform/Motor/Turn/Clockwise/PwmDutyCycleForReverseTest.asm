	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Motor.inc"

	radix decimal

PwmDutyCycleForReverseTest code
	global testArrangeStartTurning
	global testActReverse

testArrangeStartTurning:
	fcall turnMotorAntiClockwise
	return

testActReverse:
	fcall turnMotorClockwise
	return

	end
