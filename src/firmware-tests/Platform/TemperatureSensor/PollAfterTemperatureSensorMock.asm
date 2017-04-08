	#include "Platform.inc"
	#include "PollChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledPollAfterTemperatureSensor

calledPollAfterTemperatureSensor res 1

PollAfterTemperatureSensorMock code
	global initialisePollAfterTemperatureSensorMock
	global POLL_AFTER_TEMPERATURESENSOR

initialisePollAfterTemperatureSensorMock:
	banksel calledPollAfterTemperatureSensor
	clrf calledPollAfterTemperatureSensor
	return

POLL_AFTER_TEMPERATURESENSOR:
	mockCalled calledPollAfterTemperatureSensor
	return

	end
