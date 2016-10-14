	#define __CLUCK2SESAME_CLOCK_ASM

	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "Clock.inc"
	radix decimal

SECONDS_PER_TIMER_OVERFLOW_BCD equ 0x16

	#define increment RBA
	#define modulus RBB

	extern clockFlags

	udata
	global clockYearBcd
	global clockMonthBcd
	global clockDayBcd
	global clockHourBcd
	global clockMinuteBcd
	global clockSecondBcd

clockYearBcd res 1
clockMonthBcd res 1
clockDayBcd res 1
clockHourBcd res 1
clockMinuteBcd res 1
clockSecondBcd res 1

Clock code
	global updateClock

setIncrement macro literalBcd
	movlw literalBcd
	movwf increment
	endm

setModulus macro literalBcd
	movlw literalBcd
	movwf modulus
	endm

setTimePartPointer macro timePart
	movlw low timePart
	movwf FSR
	endm

incrementAndThenReturnIfNotOverflowed macro timePartBcd
	setTimePartPointer timePartBcd
	call addToTimePart
	btfss STATUS, C
	return
	endm

updateClock:
	banksel clockFlags
	btfss clockFlags, CLOCK_FLAG_TICKED
	return

	bcf clockFlags, CLOCK_FLAG_TICKED

addSecondsSinceLastTimerOverflow:
	banksel increment
	bankisel clockSecondBcd
	setIncrement SECONDS_PER_TIMER_OVERFLOW_BCD
	setModulus 0x60
	incrementAndThenReturnIfNotOverflowed clockSecondBcd

overflowedIntoNextMinute:
	setIncrement 0x01
	incrementAndThenReturnIfNotOverflowed clockMinuteBcd

overflowedIntoNextHour:
	setModulus 0x24
	incrementAndThenReturnIfNotOverflowed clockHourBcd

overflowedIntoNextDay:
	setModulus 0xff
	incrementAndThenReturnIfNotOverflowed clockDayBcd

	; TODO: OVERFLOWED INTO NEXT MONTH...ETC.

	return

;
; Inputs:
;     INDF = Pointer to the part of the (BCD) time to increment
;     RBA  = The size of the increment (BCD)
;     RBB  = The modulus for the increment
;
; Outputs:
;     INDF     = The (modulus'd) incremented quantity
;     STATUS.C = Set if the increment overflowed the modulus
;
addToTimePart:
	movf INDF, W
	movwf RAA
	fcall addBcd

	movf modulus, W
	subwf RAA, W
	btfsc STATUS, C
	goto overflowed

	movf RAA, W
	movwf INDF
	return

overflowed:
	movwf INDF
	return

	end
