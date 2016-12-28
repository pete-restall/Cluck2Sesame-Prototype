	#define __CLUCK2SESAME_PLATFORM_CORDIC_REGISTERS_ASM

	#include "Mcu.inc"
	#include "Cordic.inc"

	radix decimal

	udata
	global cordicArgument
	global cordicArgumentHigh
	global cordicArgumentLow

	global cordicIterationNumber

	global cordicError
	global cordicErrorUpper
	global cordicErrorUpperHigh
	global cordicErrorUpperLow
	global cordicErrorLower
	global cordicErrorLowerHigh
	global cordicErrorLowerLow

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

	global cordicResult
	global cordicResultHigh
	global cordicResultLow

cordicArgument:
cordicArgumentHigh res 1
cordicArgumentLow res 1

cordicIterationNumber res 1

cordicError:
cordicErrorUpper:
cordicErrorUpperHigh res 1
cordicErrorUpperLow res 1
cordicErrorLower:
cordicErrorLowerHigh res 1
cordicErrorLowerLow res 1

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

cordicResult:
cordicResultHigh res 1
cordicResultLow res 1

	end
