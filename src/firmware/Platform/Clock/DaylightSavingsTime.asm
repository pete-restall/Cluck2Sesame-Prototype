	#define __CLUCK2SESAME_PLATFORM_CLOCK_ASM

	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "Flash.inc"
	#include "ArithmeticBcd.inc"
	#include "Clock.inc"

	radix decimal

	extern daylightSavingsTimeLookupTable

EARLIEST_FIRST_DAYLIGHT_SAVINGS_DAY equ 83
EARLIEST_LAST_DAYLIGHT_SAVINGS_DAY equ low(296)

Clock code
	global isDaylightSavingsTime

isDaylightSavingsTime:
	.safelySetBankFor clockYearBcd
	movf clockYearBcd, W
	.setBankFor RAA
	movwf RAA
	fcall bcdToBinary

lookupDaylightSavingsTimeExtentsForYear:
	.setBankFor EEADR
	movwf EEADR
	bcf STATUS, C
	rrf EEADR
	movlw low(daylightSavingsTimeLookupTable)
	addwf EEADR
	.setBankFor EEADRH
	movlw high(daylightSavingsTimeLookupTable)
	movwf EEADRH
	btfsc STATUS, C
	incf EEADRH

	fcall readFlashWordAsPairOfSevenBitBytes

	.setBankFor clockYearBcd
	btfsc clockYearBcd, 0
	goto oddYear

evenYear:
	goto checkDayOfYear

oddYear:
	.knownBank clockYearBcd
	.setBankFor EEDAT
	movf EEDAT, W

checkDayOfYear:
	.safelySetBankFor dayOfYearHigh
	movf dayOfYearHigh
	btfss STATUS, Z
	goto checkHighRangeForDayOfYear

checkLowRangeForDayOfYear:
	.setBankFor RAA
	movwf RAA
	swapf RAA, W
	andlw b'00000111'
	addlw EARLIEST_FIRST_DAYLIGHT_SAVINGS_DAY

	.setBankFor dayOfYearLow
	subwf dayOfYearLow, W
	btfsc STATUS, C
	retlw 1
	retlw 0

checkHighRangeForDayOfYear:
	.knownBank dayOfYearHigh
	andlw b'00000111'
	addlw EARLIEST_LAST_DAYLIGHT_SAVINGS_DAY + 1

	.setBankFor dayOfYearLow
	subwf dayOfYearLow, W
	btfsc STATUS, C
	retlw 0
	retlw 1

	end
