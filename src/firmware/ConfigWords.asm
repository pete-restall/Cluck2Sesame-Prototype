	#include "p16f685.inc"
	radix decimal

;configword code _CONFIG
;	dw _FOSC_INTRCIO & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_SBODEN & _IESO_OFF & _FCMEN_OFF
	config FOSC=INTRCIO
	config WDTE=OFF
	config PWRTE=ON
	config MCLRE=ON
	config CP=OFF
	config CPD=OFF
	config BOREN=SBODEN
	config IESO=OFF
	config FCMEN=OFF

;idlocs code _IDLOC0
;	db 0x00
;	db 0x00
;	db 0x00
;	db 0x00

	end
