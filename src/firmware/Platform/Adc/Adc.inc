	#ifndef __CLUCK2SESAME_PLATFORM_ADC_ADC_INC
	#define __CLUCK2SESAME_PLATFORM_ADC_ADC_INC
	#include "Platform.inc"

	radix decimal

	.module ADC

ADCON0_CHANNEL_MASK equ b'00111100'
ADCON0_UNUSED_CHANNEL equ b'00110100'

	#define __CLUCK2SESAME_PLATFORM_ADC_EQUONLY
	#include "../Adc.inc"

	#endif
