	#include "Mcu.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialisePowerManagement
	global calledPollPowerManagement
	global calledPreventSleep
	global calledEnsureFastClock
	global calledAllowSlowClock

calledInitialisePowerManagement res 1
calledPollPowerManagement res 1
calledPreventSleep res 1
calledEnsureFastClock res 1
calledAllowSlowClock res 1

PowerManagementMocks code
	global initialisePowerManagementMocks
	global initialisePowerManagement
	global pollPowerManagement
	global preventSleep
	global ensureFastClock
	global allowSlowClock

initialisePowerManagementMocks:
	banksel calledInitialisePowerManagement
	clrf calledInitialisePowerManagement
	clrf calledPollPowerManagement
	clrf calledPreventSleep
	clrf calledEnsureFastClock
	clrf calledAllowSlowClock
	return

initialisePowerManagement:
	mockCalled calledInitialisePowerManagement
	return

pollPowerManagement:
	mockCalled calledPollPowerManagement
	return

preventSleep:
	mockCalled calledPreventSleep
	return

ensureFastClock:
	mockCalled calledEnsureFastClock
	return

allowSlowClock:
	mockCalled calledAllowSlowClock
	return

	end
