	#define __CLUCK2SESAME_CLOCK_ASM

	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "ArithmeticBcd.inc"
	#include "Clock.inc"

	radix decimal

SECONDS_PER_TIMER_OVERFLOW_BCD equ 0x16
TWELVE_MONTHS_MODULUS equ 1 + 0x12
YEAR99_MODULUS equ 0xa0

	#define increment RBA
	#define modulus RBB

	extern lookupNumberOfDaysInMonthBcd
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

setDateTimePartPointer macro dateTimePart
	movlw low dateTimePart
	movwf FSR
	endm

incrementAndThenReturnIfNotOverflowed macro dateTimePartBcd
	setDateTimePartPointer dateTimePartBcd
	call addToDateTimePart
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
	banksel clockMonthBcd
	movf clockMonthBcd, W
	sublw 0x02
	btfss STATUS, Z
	goto lookupNonFebruaryNumberOfDaysInMonthBcd

lookupFebruaryNumberOfDaysInMonthBcd:
checkIfYearIsDivisibleByFour:
	movf clockYearBcd, W
	banksel RAA
	movwf RAA
	fcall bcdToBinary
	andlw b'00000011'

februaryHasTwentyEightOrNineDays:
	movlw 0x28
	btfsc STATUS, Z
	movlw 0x29

restoreRbbThatWasTrashedByBcdToBinaryCallThenResumeIncrementing:
	clrf increment
	incf increment
	goto setModulusToDaysInMonthOffsetByOneAndIncrementDay

lookupNonFebruaryNumberOfDaysInMonthBcd:
	movf clockMonthBcd, W
	banksel RBB
	movwf RBB
	fcall lookupNumberOfDaysInMonthBcd

setModulusToDaysInMonthOffsetByOneAndIncrementDay:
	banksel modulus
	movwf modulus
	incf modulus
	incrementAndThenReturnIfNotOverflowed clockDayBcd

overflowedIntoNextMonth:
	banksel clockDayBcd
	clrf clockDayBcd
	incf clockDayBcd

	banksel modulus
	setModulus TWELVE_MONTHS_MODULUS
	incrementAndThenReturnIfNotOverflowed clockMonthBcd

overflowedIntoNextYear:
	banksel clockMonthBcd
	clrf clockMonthBcd
	incf clockMonthBcd

	banksel modulus
	setModulus YEAR99_MODULUS
	incrementAndThenReturnIfNotOverflowed clockYearBcd

	return

;
; !!! Will not work for general BCD modulus / increment combinations !!!
; This function does not generalise to non-date / time modulus addition.
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
addToDateTimePart:
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
