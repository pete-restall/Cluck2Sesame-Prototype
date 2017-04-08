	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	#include "TestDoubles.inc"

	radix decimal

	extern initialisationCompleted

	udata
calledPreventSleep res 1
calledPollForWork res 1
calledAllowSlowClock res 1

InitialPollBeforeLowPowerStateTest code
	global testArrange
	global pollForWork
	global initialisePowerManagement
	global pollPowerManagement
	global preventSleep
	global ensureFastClock
	global allowSlowClock

testArrange:
	banksel calledPollForWork
	clrf calledPollForWork
	clrf calledPreventSleep
	clrf calledAllowSlowClock

testAct:
	fcall initialisationCompleted

testAssert:
	.aliasForAssert calledPreventSleep, _a
	.aliasForAssert calledPollForWork, _b
	.assert "_a != 0 && _b > _a, 'Expected pollForWork() to be called after preventSleep().'"

	.aliasForAssert calledPollForWork, _a
	.aliasForAssert calledAllowSlowClock, _b
	.assert "_a != 0 && _b > _a, 'Expected allowSlowClock() to be called after pollForWork().'"
	return

pollForWork:
	mockCalled calledPollForWork

	banksel INTCON
	btfsc INTCON, GIE
	return

	.assert "false, 'Expected interrupts to be enabled prior to pollForWork().'"
	return

initialisePowerManagement:
	.assert "false, 'Expected initialisePowerManagement() was not called.'"
	return

pollPowerManagement:
	.assert "false, 'Expected pollPowerManagement() was not called.'"
	return

preventSleep:
	mockCalled calledPreventSleep
	return

ensureFastClock:
	.assert "false, 'Expected ensureFastClock() was not called.'"
	return

allowSlowClock:
	mockCalled calledAllowSlowClock
	return

	end
