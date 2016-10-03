	#include "p16f685.inc"
	radix decimal

TMR1CS_MASK equ (1 << TMR1CS)
T1OSCEN_MASK equ (1 << T1OSCEN)
T1SYNC_ASYNC_MASK equ (1 << NOT_T1SYNC)
T1CKPS_DIVIDE_BY_8_MASK equ (1 << T1CKPS1) | (1 << T1CKPS0)
TMR1ON_MASK equ (1 << TMR1ON)

Clock code
	global initialiseAfterReset
	global initialiseClock

initialiseAfterReset:
initialiseClock:
	banksel T1CON
	movlw TMR1CS_MASK | T1OSCEN_MASK | T1CKPS_DIVIDE_BY_8_MASK | T1SYNC_ASYNC_MASK | TMR1ON_MASK

	movwf T1CON

	return

	end
