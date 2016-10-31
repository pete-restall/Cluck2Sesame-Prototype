	#define __CLUCK2SESAME_TESTS_TESTFIXTURE_ASM

	#include "p16f685.inc"
	#include "FarCalls.inc"
	#include "TestFixture.inc"
	#include "TestDoubles.inc"

	radix decimal

	extern testArrange


	; Non-obvious - gpsim .assert expressions use the same bank as currently
	; selected.  Use the .aliasForAssert macro in TestFixture.inc along with
	; these variables to work around expressions asserting over several banks.

assertAliases udata_shr
	global _a
	global _b

_a res 1
_b res 2

TestFixtureBoot code 0x0000
	fgoto runTest

TestFixture code
runTest:
	call enableTimer0ForTestNonDeterminism
	fcall initialiseTestDoubles
	fcall testArrange
	.done

enableTimer0ForTestNonDeterminism:
	banksel OPTION_REG
	bcf OPTION_REG, T0CS
	bcf OPTION_REG, PSA
	bcf OPTION_REG, PS0
	bcf OPTION_REG, PS1
	bcf OPTION_REG, PS2
	return

	end
