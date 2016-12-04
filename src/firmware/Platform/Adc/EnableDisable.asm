	#include "Mcu.inc"
	#include "FarCalls.inc"
	#include "PowerManagement.inc"

	radix decimal

	udata
	global enableAdcCount

enableAdcCount res 1

Adc code
	global enableAdc
	global disableAdc

enableAdc:
	fcall ensureFastClock

	banksel enableAdcCount
	incf enableAdcCount, W
	incf enableAdcCount
	sublw 1
	btfss STATUS, Z
	return

enableAdcOnlyOnTheFirstCall:
	banksel ADCON0
	bsf ADCON0, ADON
	bsf ADCON0, GO
	return

disableAdc:
	fcall allowSlowClock

	banksel enableAdcCount
	decfsz enableAdcCount
	return

	banksel ADCON0
	bcf ADCON0, ADON
	return

	end
