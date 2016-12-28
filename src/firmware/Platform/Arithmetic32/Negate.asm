	#include "Mcu.inc"
	#include "GeneralPurposeRegisters.inc"

	radix decimal

Arithmetic32 code
	global negateA32
	global negateB32

negate32 macro reg
	local twosComplement
	local adjustCarryAndZeroFlags

twosComplement:
	banksel reg
	comf reg + 0
	comf reg + 1
	comf reg + 2
	comf reg + 3
	bcf STATUS, Z
	bcf STATUS, C
	incfsz reg + 3
	return
	incfsz reg + 2
	return
	incfsz reg + 1
	return
	incf reg + 0

adjustCarryAndZeroFlags:
	movf reg + 0, W
	xorlw 0x80
	btfsc STATUS, Z
	bsf STATUS, C
	movf reg + 0
	btfsc STATUS, Z
	bsf STATUS, C
	endm

negateA32:
	negate32 RAA
	return

negateB32:
	negate32 RBA
	return

	end

