	#define __CLUCK2SESAME_CLOCK_ASM

	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "Clock.inc"
	radix decimal

TMR1CS_MASK equ (1 << TMR1CS)
T1OSCEN_MASK equ (1 << T1OSCEN)
T1SYNC_ASYNC_MASK equ (1 << NOT_T1SYNC)
T1CKPS_DIVIDE_BY_8_MASK equ (1 << T1CKPS1) | (1 << T1CKPS0)
TMR1ON_MASK equ (1 << TMR1ON)
SECONDS_PER_TIMER_OVERFLOW_BCD equ 0x16

addQuantityTo macro timePartBcd, literalQuantityBcd
	movf timePartBcd, W
	banksel RAA
	movwf RAA
	movlw literalQuantityBcd
	movwf RBA
	fcall addBcd
	endm

storeAndThenReturnWhenNotOverflowed macro timePartBcd, overflowQuantityBcd
	local overflowed

	movlw overflowQuantityBcd
	subwf RAA, W
	btfsc STATUS, C
	goto overflowed

	movf RAA, W
	banksel timePartBcd
	movwf timePartBcd
	return

overflowed:
	banksel timePartBcd
	movwf timePartBcd
	endm

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

addSecondsSinceLastTimerOverflow:
	addQuantityTo clockSecondBcd, SECONDS_PER_TIMER_OVERFLOW_BCD
	storeAndThenReturnWhenNotOverflowed clockSecondBcd, 0x60

overflowedIntoNextMinute:
	addQuantityTo clockMinuteBcd, 0x01
	storeAndThenReturnWhenNotOverflowed clockMinuteBcd, 0x60

overflowedIntoNextHour:
	addQuantityTo clockHourBcd, 0x01
	storeAndThenReturnWhenNotOverflowed clockHourBcd, 0x24

overflowedIntoNextDay:
	addQuantityTo clockDayBcd, 0x01
	storeAndThenReturnWhenNotOverflowed clockDayBcd, 0xff

	return

	end
