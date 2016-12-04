	#include "Mcu.inc"
	#include "InitialisationChain.inc"
	#include "TestDoubles.inc"

	radix decimal

	udata
	global calledInitialiseAfterPowerManagement

calledInitialiseAfterPowerManagement res 1

InitialiseAfterPowerManagementMock code
	global initialiseInitialiseAfterPowerManagementMock
	global INITIALISE_AFTER_POWERMANAGEMENT

initialiseInitialiseAfterPowerManagementMock:
	banksel calledInitialiseAfterPowerManagement
	clrf calledInitialiseAfterPowerManagement
	return

INITIALISE_AFTER_POWERMANAGEMENT:
	mockCalled calledInitialiseAfterPowerManagement
	return

	end
