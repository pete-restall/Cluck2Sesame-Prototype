	#include "p16f685.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterMotor

calledInitialiseAfterMotor res 1

InitialiseAfterMotorMock code
	global initialiseInitialiseAfterMotorMock
	global INITIALISE_AFTER_MOTOR

initialiseInitialiseAfterMotorMock:
	banksel calledInitialiseAfterMotor
	clrf calledInitialiseAfterMotor
	return

INITIALISE_AFTER_MOTOR:
	mockCalled calledInitialiseAfterMotor
	return

	end
