	#define __CLUCK2SESAME_PLATFORM_CLOCK_ASM

	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "ResetFlags.inc"
	#include "Clock.inc"

	radix decimal

TMR1CS_MASK equ (1 << TMR1CS)
T1OSCEN_MASK equ (1 << T1OSCEN)
T1SYNC_ASYNC_MASK equ (1 << NOT_T1SYNC)
T1CKPS_DIVIDE_BY_8_MASK equ (1 << T1CKPS1) | (1 << T1CKPS0)
TMR1ON_MASK equ (1 << TMR1ON)

	extern INITIALISE_AFTER_CLOCK

Clock code
	global initialiseAfterReset
	global initialiseClock

initialiseAfterReset:
initialiseClock:
	banksel clockFlags
	clrf clockFlags

	banksel T1CON
	movlw TMR1CS_MASK | T1OSCEN_MASK | T1CKPS_DIVIDE_BY_8_MASK | T1SYNC_ASYNC_MASK | TMR1ON_MASK
	movwf T1CON

	banksel PIE1
	bsf PIE1, TMR1IE

	fcall isLastResetDueToBrownOut
	xorlw 0
	btfss STATUS, Z
	goto returnFromClockInitialisation

clearDateAndTimeAfterNonBrownOutReset:
	banksel clockYearBcd
	movlw 1
	clrf clockYearBcd
	movwf clockMonthBcd
	movwf clockDayBcd
	clrf clockHourBcd
	clrf clockMinuteBcd
	clrf clockSecondBcd
	clrf dayOfYearHigh
	clrf dayOfYearLow

returnFromClockInitialisation:
	tcall INITIALISE_AFTER_CLOCK

	end
