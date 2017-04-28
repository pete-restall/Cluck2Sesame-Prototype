	#include "Platform.inc"
	#include "PowerManagement.inc"
	#include "Timer0.inc"

	radix decimal

OSCCON_HFINTOSC_4MHZ equ b'01100001'
OSCCON_LFINTOSC_31KHZ equ b'00000001'

PowerManagement code
	global ensureFastClock
	global allowSlowClock

ensureFastClock:
	.safelySetBankFor fastClockCount
	incf fastClockCount

	.setBankFor OSCCON
	movlw OSCCON_HFINTOSC_4MHZ
	movwf OSCCON

waitUntilHfintoscIsStable:
	btfss OSCCON, HTS
	goto waitUntilHfintoscIsStable

clearSlowTmr0OverflowIfFastClockFirstTime:
	.setBankFor fastClockCount
	decfsz fastClockCount, W
	return

	.setBankFor slowTmr0
	extern tmr0Overflow
	clrf tmr0Overflow

	.setBankFor TMR0
	movf TMR0
	return

allowSlowClock:
	.safelySetBankFor fastClockCount
	decfsz fastClockCount
	return

	.setBankFor OSCCON
	movlw OSCCON_LFINTOSC_31KHZ
	movwf OSCCON
	return

	end
