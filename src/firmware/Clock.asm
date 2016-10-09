	#define __CLUCK2SESAME_CLOCK_ASM

	#include "p16f685.inc"
	#include "Clock.inc"
	radix decimal

TMR1CS_MASK equ (1 << TMR1CS)
T1OSCEN_MASK equ (1 << T1OSCEN)
T1SYNC_ASYNC_MASK equ (1 << NOT_T1SYNC)
T1CKPS_DIVIDE_BY_8_MASK equ (1 << T1CKPS1) | (1 << T1CKPS0)
TMR1ON_MASK equ (1 << TMR1ON)

	udata
	global clockFlags
	global clockYearBcd
	global clockMonthBcd
	global clockDayBcd
	global clockHourBcd
	global clockMinuteBcd
	global clockSecondBcd

clockFlags res 1
clockYearBcd res 1
clockMonthBcd res 1
clockDayBcd res 1
clockHourBcd res 1
clockMinuteBcd res 1
clockSecondBcd res 1

Clock code
	global initialiseAfterReset
	global initialiseClock
	global updateClock

initialiseAfterReset:
initialiseClock:
	banksel clockFlags
	clrf clockFlags

	banksel T1CON
	movlw TMR1CS_MASK | T1OSCEN_MASK | T1CKPS_DIVIDE_BY_8_MASK | T1SYNC_ASYNC_MASK | TMR1ON_MASK

	movwf T1CON

	return

updateClock:
	banksel clockFlags
	btfss clockFlags, CLOCK_FLAG_TICKED
	return

	bcf clockFlags, CLOCK_FLAG_TICKED

	movlw 0x16
	addwf clockSecondBcd
	movlw 0x1a
	subwf clockSecondBcd, W
	btfss STATUS, Z
	return

	movlw 0x20
	movwf clockSecondBcd

	return

	end
