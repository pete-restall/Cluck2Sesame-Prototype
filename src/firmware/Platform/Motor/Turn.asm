	#include "Mcu.inc"
	#include "Motor.inc"
	#include "States.inc"

	radix decimal

Motor code
	global turnMotorClockwise

turnMotorClockwise:
	; TODO: IF motorState != MOTOR_STATE_IDLE || MOTOR_STATE_TURNING_*, RETURN 0...

	setMotorState MOTOR_STATE_SOFTSTART
	return

	end
