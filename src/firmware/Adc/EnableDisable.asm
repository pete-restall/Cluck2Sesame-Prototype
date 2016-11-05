	#include "p16f685.inc"

	radix decimal

	udata
	global enableAdcCount

enableAdcCount res 1

Adc code
	global enableAdc
	global disableAdc

enableAdc:
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
	banksel enableAdcCount
	decfsz enableAdcCount
	return

	banksel ADCON0
	bcf ADCON0, ADON
	return

	end
