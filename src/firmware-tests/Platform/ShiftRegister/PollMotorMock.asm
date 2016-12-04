	#include "Mcu.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPollMotor

calledPollMotor res 1

PollMotorMock code
	global initialisePollMotorMock
	global pollMotor

initialisePollMotorMock:
	banksel calledPollMotor
	clrf calledPollMotor
	return

pollMotor:
	mockCalled calledPollMotor
	return

	end
