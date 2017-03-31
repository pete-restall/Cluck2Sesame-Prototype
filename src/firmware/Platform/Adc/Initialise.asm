	#include "Mcu.inc"
	#include "TailCalls.inc"
	#include "InitialisationChain.inc"
	#include "Adc.inc"

	radix decimal

	constrainedToMcuFastClockFrequencyHz 4000000

LEFT_JUSTIFIED_MASK equ 0x00
VDD_AS_VREF_MASK equ 0x00
DEFAULT_CHANNEL_MASK equ ADCON0_UNUSED_CHANNEL

ADCON0_MASK equ LEFT_JUSTIFIED_MASK | VDD_AS_VREF_MASK | DEFAULT_CHANNEL_MASK

DIVIDE_BY_32 equ b'00100000'

	extern INITIALISE_AFTER_ADC
	extern enableAdcCount

Adc code
	global initialiseAdc

initialiseAdc:
	banksel enableAdcCount
	clrf enableAdcCount

	banksel ADCON0
	movlw ADCON0_MASK
	movwf ADCON0

	banksel ADCON1
	movlw DIVIDE_BY_32
	movwf ADCON1

	banksel PIR1
	bcf PIR1, ADIF

	banksel PIE1
	bsf PIE1, ADIE

	tcall INITIALISE_AFTER_ADC

	end
