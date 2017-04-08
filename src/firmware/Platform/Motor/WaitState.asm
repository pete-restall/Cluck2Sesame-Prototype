	#include "Platform.inc"
	#include "Timer0.inc"
	#include "States.inc"
	#include "WaitState.inc"

	radix decimal

	defineMotorState MOTOR_STATE_WAIT
checkIfExpectedNumberOfTicksHasElapsed:
		elapsedSinceTimer0 MOTOR_WAIT_PARAM_INITIAL_TICKS
		.setBankFor MOTOR_WAIT_PARAM_NUMBER_OF_TICKS
		subwf MOTOR_WAIT_PARAM_NUMBER_OF_TICKS, W

		btfss STATUS, C
		goto greaterThanOrEqualToTicks

		btfss STATUS, Z
		goto endOfState

greaterThanOrEqualToTicks:
		movf motorNextState, W
		movwf motorState

endOfState:
		returnFromMotorState

	end
