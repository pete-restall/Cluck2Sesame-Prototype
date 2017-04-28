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

returnWithoutModifyingAdcon0IfCurrentChannelIsNotSameOrUnused:
	.setBankFor ADCON0
	andwf ADCON0, W
	xorlw ADCON0_UNUSED_CHANNEL
	btfsc STATUS, Z
	goto switchToNewChannel

channelIsNotUnused:
	.setBankFor RZA
	xorlw ADCON0_UNUSED_CHANNEL
	xorwf RZA, W
	btfss STATUS, Z
	retlw SET_ADC_CHANNEL_FAILURE
	retlw SET_ADC_CHANNEL_SAME

switchToNewChannel:
	.knownBank ADCON0
	movlw ~ADCON0_CHANNEL_MASK
	andwf ADCON0, W
	.setBankFor RZA
	iorwf RZA, W
	.setBankFor ADCON0
	movwf ADCON0
	retlw SET_ADC_CHANNEL_SUCCESS

releaseAdcChannel:
	.safelySetBankFor RZA
	movlw ADCON0_UNUSED_CHANNEL
	movwf RZA
	.setBankFor ADCON0
	goto switchToNewChannel

	end
