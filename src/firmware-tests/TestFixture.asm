	#include "p16f685.inc"
	#include "FarCalls.inc"
	radix decimal

	extern initialiseTestDoubles
	extern testArrange

boot code 0x0000
	fgoto runTest

	code
runTest:
	fcall initialiseTestDoubles
	fgoto testArrange

	end
