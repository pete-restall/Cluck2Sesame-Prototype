	#ifndef __CLUCK2SESAME_PLATFORM_ADC_INC
	#define __CLUCK2SESAME_PLATFORM_ADC_INC

	radix decimal

SET_ADC_CHANNEL_FAILURE equ 0
SET_ADC_CHANNEL_SUCCESS equ 1
SET_ADC_CHANNEL_SAME equ 2

	#ifndef __CLUCK2SESAME_PLATFORM_ADC_EQUONLY
	extern initialiseAdc
	extern enableAdc
	extern disableAdc
	extern setAdcChannel
	extern releaseAdcChannel
	#endif

	#endif
