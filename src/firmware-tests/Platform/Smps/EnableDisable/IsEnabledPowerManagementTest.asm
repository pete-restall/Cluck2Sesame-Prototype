	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Timer0.inc"
	#include "PowerManagement.inc"
	#include "Smps.inc"
	#include "TestFixture.inc"

	radix decimal

OSCCON_LFINTOSC_31KHZ equ (1 << OSTS) | (1 << SCS) | (1 << LTS)

IsEnabledPowerManagementTest code
	global testArrange

testArrange:
	fcall initialiseTimer0
	fcall initialisePowerManagement
	fcall initialiseSmps
	fcall disableSmps
	fcall pollSmps

	call initialiseTimer1

waitForTimer1Synchronisation:
	banksel TMR1
	movf TMR1, W
	btfsc STATUS, Z
	goto waitForTimer1Synchronisation

	clrf TMR1

testAct:
	fcall allowSlowClock
	fcall enableSmps

keepPollingUntilTimer1TicksOrSmpsIsEnabled:
	fcall pollSmps
	fcall isSmpsEnabled
	xorlw 0
	btfss STATUS, Z
	goto testAssert

	fcall pollPowerManagement
	banksel TMR1
	movf TMR1, W
	btfsc STATUS, Z
	goto keepPollingUntilTimer1TicksOrSmpsIsEnabled

testAssert:
	.aliasForAssert OSCCON, _a
	.aliasLiteralForAssert OSCCON_LFINTOSC_31KHZ, _b
	.assert "_a == _b, 'Expected slow clock.'"

	fcall isSmpsEnabled
	.aliasWForAssert _a
	.assert "_a != 0, 'Expected SMPS to be enabled.'"
	return

initialiseTimer1:
	banksel T1CON
	movlw (1 << TMR1CS) | (1 << T1OSCEN)
	movwf T1CON

	banksel TMR1H
	clrf TMR1H
	clrf TMR1L

	banksel T1CON
	bsf T1CON, TMR1ON
	return

	end
