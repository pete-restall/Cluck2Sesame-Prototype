	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "Isr.inc"
	#include "../../../../firmware/Platform/PowerManagement/PowerManagement.inc"
	#include "TestFixture.inc"

	radix decimal

	extern isr

	udata
expectedPowerManagementFlags res 1

PreventSleepTest code
	global testArrange

testArrange:
	banksel TMR0
	movf TMR0, W
	banksel powerManagementFlags
	movwf powerManagementFlags
	bcf powerManagementFlags, POWER_FLAG_PREVENTSLEEP
	movf powerManagementFlags, W

	banksel expectedPowerManagementFlags
	movwf expectedPowerManagementFlags
	bsf expectedPowerManagementFlags, POWER_FLAG_PREVENTSLEEP

testAct:
	fcall isr

testAssert:
	.aliasForAssert powerManagementFlags, _a
	.aliasForAssert expectedPowerManagementFlags, _b
	.assert "_a == _b, 'The ISR did not (only) set POWER_FLAG_PREVENTSLEEP.'"
	return

	end
