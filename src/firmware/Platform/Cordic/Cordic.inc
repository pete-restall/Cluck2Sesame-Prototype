	#ifndef __CLUCK2SESAME_PLATFORM_CORDIC_CORDIC_INC
	#define __CLUCK2SESAME_PLATFORM_CORDIC_CORDIC_INC

	radix decimal

CORDIC_FLAG_ERRORPOSITIVE equ 0

NUMBER_OF_ITERATIONS equ 15

DEGREES_90 equ 0x4000
DEGREES_NEGATIVE90 equ 0xc000

GAIN_RECIPROCAL equ 0x4dba
HYPERBOLIC_GAIN_RECIPROCAL equ 0x1a42

	#ifndef __CLUCK2SESAME_PLATFORM_CORDIC_ARCTANGENTLOOKUP_ASM
	extern arcTangentLookup
	#endif

	#ifndef __CLUCK2SESAME_PLATFORM_CORDIC_REGISTERS_ASM
	extern cordicArgument
	extern cordicArgumentHigh
	extern cordicArgumentLow

	extern cordicFlags
	extern cordicIterationNumber

	extern cordicX
	extern cordicXUpper
	extern cordicXUpperHigh
	extern cordicXUpperLow
	extern cordicXLower
	extern cordicXLowerHigh
	extern cordicXLowerLow

	extern cordicY
	extern cordicYUpper
	extern cordicYUpperHigh
	extern cordicYUpperLow
	extern cordicYLower
	extern cordicYLowerHigh
	extern cordicYLowerLow

	extern cordicZ
	extern cordicZUpper
	extern cordicZUpperHigh
	extern cordicZUpperLow
	extern cordicZLower
	extern cordicZLowerHigh
	extern cordicZLowerLow

	extern cordicW
	extern cordicWUpper
	extern cordicWUpperHigh
	extern cordicWUpperLow
	extern cordicWLower
	extern cordicWLowerHigh
	extern cordicWLowerLow

	extern cordicResult
	extern cordicResultHigh
	extern cordicResultLow
	#endif

	#ifndef __CLUCK2SESAME_PLATFORM_CORDIC_REGISTERLOADANDSTORE_ASM
	extern loadCordicArgumentIntoA
	extern loadCordicXIntoA
	extern loadCordicXIntoCordicW
	extern loadCordicYIntoA
	extern loadCordicYIntoCordicW
	extern loadCordicZIntoA
	extern loadCordicZIntoB
	extern loadCordicWIntoB
	extern storeAIntoCordicX
	extern storeAIntoCordicY
	extern storeAIntoCordicZ
	#endif

	#ifndef __CLUCK2SESAME_PLATFORM_CORDIC_SHIFT_ASM
	extern shiftCordicWByIterationNumber
	#endif

	#endif
