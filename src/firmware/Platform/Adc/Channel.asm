	#include "Platform.inc"
	#include "GeneralPurposeRegisters.inc"
	#include "Adc.inc"

	radix decimal

Adc code
	global setAdcChannel
	global releaseAdcChannel

setAdcChannel:
storeShiftedChannelInRza:
	.safelySetBankFor RZA
	movwf RZA
	rlf RZA
	rlf RZA
	movlw ADCON0_CHANNEL_MASK
	andwf RZA

	; TODO: IF CHANNEL IS ALREADY WHAT IS SET THEN RETURN 'SET_ADC_CHANNEL_SAME'...
returnWithoutModifyingAdcon0IfCurrentChannelIsNotUnused:
	.setBankFor ADCON0
	movlw ADCON0_CHANNEL_MASK
	andwf ADCON0, W
	xorlw ADCON0_UNUSED_CHANNEL
	btfss STATUS, Z
	retlw SET_ADC_CHANNEL_FAILURE

switchToNewChannel:
	movlw ~ADCON0_CHANNEL_MASK
	andwf ADCON0, W
	.safelySetBankFor RZA
	iorwf RZA, W
	.setBankFor ADCON0
	movwf ADCON0
	retlw SET_ADC_CHANNEL_SUCCESS

releaseAdcChannel:
	.setBankFor RZA
	movlw ADCON0_UNUSED_CHANNEL
	movwf RZA
	.setBankFor ADCON0
	goto switchToNewChannel

	end
