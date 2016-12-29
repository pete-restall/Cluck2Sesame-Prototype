	#define __CLUCK2SESAME_PLATFORM_CORDIC_REGISTERS_ASM

	#include "Mcu.inc"
	#include "Cordic.inc"

	radix decimal

	udata
	global cordicArgument
	global cordicArgumentHigh
	global cordicArgumentLow

	global cordicFlags
	global cordicIterationNumber

	global cordicX
	global cordicXUpper
	global cordicXUpperHigh
	global cordicXUpperLow
	global cordicXLower
	global cordicXLowerHigh
	global cordicXLowerLow

	global cordicY
	global cordicYUpper
	global cordicYUpperHigh
	global cordicYUpperLow
	global cordicYLower
	global cordicYLowerHigh
	global cordicYLowerLow

	global cordicZ
	global cordicZUpper
	global cordicZUpperHigh
	global cordicZUpperLow
	global cordicZLower
	global cordicZLowerHigh
	global cordicZLowerLow

	global cordicW
	global cordicWUpper
	global cordicWUpperHigh
	global cordicWUpperLow
	global cordicWLower
	global cordicWLowerHigh
	global cordicWLowerLow

	global cordicResult
	global cordicResultHigh
	global cordicResultLow

cordicArgument:
cordicArgumentHigh res 1
cordicArgumentLow res 1

cordicFlags res 1
cordicIterationNumber res 1

cordicX:
cordicXUpper:
cordicXUpperHigh res 1
cordicXUpperLow res 1
cordicXLower:
cordicXLowerHigh res 1
cordicXLowerLow res 1

cordicY:
cordicYUpper:
cordicYUpperHigh res 1
cordicYUpperLow res 1
cordicYLower:
cordicYLowerHigh res 1
cordicYLowerLow res 1

cordicZ:
cordicZUpper:
cordicZUpperHigh res 1
cordicZUpperLow res 1
cordicZLower:
cordicZLowerHigh res 1
cordicZLowerLow res 1

cordicW:
cordicWUpper:
cordicWUpperHigh res 1
cordicWUpperLow res 1
cordicWLower:
cordicWLowerHigh res 1
cordicWLowerLow res 1

cordicResult:
cordicResultHigh res 1
cordicResultLow res 1

	end
