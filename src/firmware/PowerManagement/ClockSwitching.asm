	#include "p16f685.inc"
	#include "PowerManagement.inc"

	radix decimal

OSCCON_HFINTOSC_4MHZ equ b'01100001'
OSCCON_LFINTOSC_31KHZ equ b'00000001'

PowerManagement code
	global ensureFastClock
	global allowSlowClock

ensureFastClock:
	banksel fastClockCount
	incf fastClockCount

	banksel OSCCON
	movlw OSCCON_HFINTOSC_4MHZ
	movwf OSCCON

waitUntilHfintoscIsStable:
	btfss OSCCON, HTS
	goto waitUntilHfintoscIsStable
	return

allowSlowClock:
	banksel fastClockCount
	decfsz fastClockCount
	return

	banksel OSCCON
	movlw OSCCON_LFINTOSC_31KHZ
	movwf OSCCON

waitUntilLfintoscIsStable:
	btfss OSCCON, LTS
	goto waitUntilLfintoscIsStable
	return

	end
