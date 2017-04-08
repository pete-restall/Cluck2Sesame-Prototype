	#include "Platform.inc"

	radix decimal

LcdRam udata
	global lcdContrast
	global enableLcdCount
	global lcdFlags
	global lcdWorkingRegister
	global lcdState
	global lcdStateParameter0
	global lcdStateParameter1
	global lcdNextState
	global flashPointerMsb
	global flashPointerLsb
	global numberOfCharactersRemaining
	global characters

lcdContrast res 1
enableLcdCount res 1
lcdFlags res 1
lcdWorkingRegister res 1
lcdState res 1
lcdStateParameter0 res 1
lcdStateParameter1 res 1
lcdNextState res 1
flashPointerMsb res 1
flashPointerLsb res 1
numberOfCharactersRemaining res 1
characters res 2

	end
