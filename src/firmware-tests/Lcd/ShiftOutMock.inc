	#ifndef __CLUCK2SESAME_TESTS_LCD_SHIFTOUTMOCK_INC
	#define __CLUCK2SESAME_TESTS_LCD_SHIFTOUTMOCK_INC
	#include "TestFixture.inc"

	radix decimal

	extern initialiseShiftOutMock
	extern shiftRegisterBuffer
	extern calledShiftOutCount
	extern shiftRegisterBufferForCall1
	extern shiftRegisterBufferForCall2
	extern shiftRegisterBufferForCall3
	extern shiftRegisterBufferForCall4

.assertShiftOut macro count, expectedBuffer
	.aliasForAssert shiftRegisterBufferForCall#v(count), _a
	.aliasForAssert expectedBuffer, _b
	.assert "_a == _b, 'Shift Register buffer expectation mismatch in shiftOut() call.'"
	endm

	#endif
