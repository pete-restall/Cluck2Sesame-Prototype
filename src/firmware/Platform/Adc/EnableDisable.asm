	#include "Platform.inc"
	#include "FarCalls.inc"
	#include "PowerManagement.inc"

	radix decimal

AdcRam udata
	global enableAdcCount

enableAdcCount res 1

Adc code
	global enableAdc
	global disableAdc

enableAdc:
	fcall ensureFastClock

	.safelySetBankFor enableAdcCount
	incf enableAdcCount, W
	incf enableAdcCount
	sublw 1
	btfss STATUS, Z
	return

enableAdcOnlyOnTheFirstCall:
	.setBankFor ADCON0
	bsf ADCON0, ADON
	bsf ADCON0, GO
	return

disableAdc:
	fcall allowSlowClock

	.safelySetBankFor enableAdcCount
	decfsz enableAdcCount
	return

	.setBankFor ADCON0
	bcf ADCON0, ADON
	return

	end
