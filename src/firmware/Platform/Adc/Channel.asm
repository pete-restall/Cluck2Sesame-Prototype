	#include "Mcu.inc"
	#include "GeneralPurposeRegisters.inc"
	#include "Adc.inc"

	radix decimal

Adc code
	global setAdcChannel
	global releaseAdcChannel

setAdcChannel:
storeShiftedChannelInRza:
	banksel RZA
	movwf RZA
	rlf RZA
	rlf RZA
	movlw ADCON0_CHANNEL_MASK
	andwf RZA

	; TODO: IF CHANNEL IS ALREADY WHAT IS SET THEN RETURN 'SET_ADC_CHANNEL_SAME'...
returnWithoutModifyingAdcon0IfCurrentChannelIsNotUnused:
	banksel ADCON0
	movlw ADCON0_CHANNEL_MASK
	andwf ADCON0, W
	xorlw ADCON0_UNUSED_CHANNEL
	btfss STATUS, Z
	retlw SET_ADC_CHANNEL_FAILURE

switchToNewChannel:
	movlw ~ADCON0_CHANNEL_MASK
	andwf ADCON0, W
	banksel RZA
	iorwf RZA, W
	banksel ADCON0
	movwf ADCON0
	retlw SET_ADC_CHANNEL_SUCCESS

releaseAdcChannel:
	banksel RZA
	movlw ADCON0_UNUSED_CHANNEL
	movwf RZA
	banksel ADCON0
	goto switchToNewChannel

	end
