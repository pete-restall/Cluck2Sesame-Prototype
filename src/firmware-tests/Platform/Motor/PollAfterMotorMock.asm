	#include "Platform.inc"
	#include "PollChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPollAfterMotor

calledPollAfterMotor res 1

PollAfterMotorMock code
	global initialisePollAfterMotorMock
	global POLL_AFTER_MOTOR

initialisePollAfterMotorMock:
	banksel calledPollAfterMotor
	clrf calledPollAfterMotor
	return

POLL_AFTER_MOTOR:
	mockCalled calledPollAfterMotor
	return

	end
