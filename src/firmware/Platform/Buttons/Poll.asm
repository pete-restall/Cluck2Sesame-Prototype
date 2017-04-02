	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "PollChain.inc"
	#include "Timer0.inc"
	#include "Buttons.inc"

	radix decimal

	extern POLL_AFTER_BUTTONS

NUMBER_OF_TICKS_25MS equ 195

pollForButton macro portBit, number
	local buttonSampledOpen
	local buttonSampledClosed
	local buttonSampledClosedForFirstTime
	local buttonSampledClosedMultipleTimes
	local endOfButtonSampling

	banksel PORTB
	btfsc PORTB, portBit
	goto buttonSampledOpen

buttonSampledClosed:
	btfsc buttonFlags, BUTTON_FLAG_PRESSED#v(number)
	goto endOfButtonSampling

	btfsc buttonFlags, BUTTON_FLAG_POTENTIALLY#v(number)
	goto buttonSampledClosedMultipleTimes

buttonSampledClosedForFirstTime:
	bsf buttonFlags, BUTTON_FLAG_POTENTIALLY#v(number)
	storeTimer0 button#v(number)Timestamp
	goto endOfButtonSampling

buttonSampledClosedMultipleTimes:
	elapsedSinceTimer0 button#v(number)Timestamp
	sublw NUMBER_OF_TICKS_25MS
	banksel buttonFlags
	btfss STATUS, C
	bsf buttonFlags, BUTTON_FLAG_PRESSED#v(number)
	goto endOfButtonSampling

buttonSampledOpen:
	banksel buttonFlags
	bcf buttonFlags, BUTTON_FLAG_PRESSED#v(number)
	bcf buttonFlags, BUTTON_FLAG_POTENTIALLY#v(number)

endOfButtonSampling:
	endm

Buttons code
	global pollButtons

pollButtons:
	pollForButton RB6, 1
	pollForButton RB5, 2
	tcall POLL_AFTER_BUTTONS

	end
