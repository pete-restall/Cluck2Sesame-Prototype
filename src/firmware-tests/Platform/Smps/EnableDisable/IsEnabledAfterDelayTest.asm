	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Smps.inc"
	#include "TestFixture.inc"

	radix decimal

	udata
	global initialTmr0
	global tmr0Increment
	global expectIsSmpsEnabled

initialTmr0 res 1
tmr0Increment res 1
expectIsSmpsEnabled res 1

IsEnabledAfterDelayTest code
	global testArrange

testArrange:
	fcall initialiseSmps
	fcall disableSmps
	fcall pollSmps

overrideTimer0:
	banksel OPTION_REG
	bsf OPTION_REG, T0CS

testAct:
	banksel initialTmr0
	movf initialTmr0, W
	banksel TMR0
	movwf TMR0

	fcall enableSmps
	fcall pollSmps

	banksel tmr0Increment
	movf tmr0Increment, W
	banksel TMR0
	addwf TMR0

	fcall pollSmps

testAssert:
	fcall isSmpsEnabled
	.aliasWForAssert _a

	banksel expectIsSmpsEnabled
	movf expectIsSmpsEnabled
	btfss STATUS, Z
	goto assertSmpsIsEnabled

assertSmpsIsDisabled:
	.assert "_a == 0, 'Expected SMPS to be disabled.'"
	return

assertSmpsIsEnabled:
	.assert "_a != 0, 'Expected SMPS to be enabled.'"
	return

	end
