	#include "p16f685.inc"
	radix decimal

	config FOSC=INTRCIO
	config WDTE=OFF
	config PWRTE=ON
	config MCLRE=ON
	config CP=OFF
	config CPD=OFF
	config BOREN=SBODEN
	config IESO=OFF
	config FCMEN=OFF

	end
