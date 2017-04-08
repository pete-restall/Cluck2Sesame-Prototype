	#ifndef __CLUCK2SESAME_PLATFORM_BANKSWITCHING_INC
	#define __CLUCK2SESAME_PLATFORM_BANKSWITCHING_INC

	radix decimal

	#define UNKNOWN_BANK -1
	#define BANK_MASK 0xff80
	#define SHARED_BANK_MASK b'01110000'

	variable currentBank = UNKNOWN_BANK

.knownBank macro bank
currentBank = bank & BANK_MASK
	endm

.unknownBank macro
currentBank = UNKNOWN_BANK
	endm

.trySafelySetBankFor macro reg1, reg2
	#ifdef reg1
	banksel reg1
	.knownBank reg1
	#else
	banksel reg2
	.knownBank reg2
	#endif
	endm

.safelySetBankFor macro reg
	.trySafelySetBankFor BANK_FOR_#v(0)reg, reg
	endm

.setOrClearRpBit macro rpBit, bankMask
	#if (reg & bankMask) != (currentBank & bankMask)
	#if (reg & bankMask)
		bsf STATUS, rpBit
	#else
		bcf STATUS, rpBit
	#endif
	#endif
	endm

.setBankFromEquFor macro reg
	#if ((reg & SHARED_BANK_MASK) != SHARED_BANK_MASK)
	#if (currentBank == UNKNOWN_BANK)
		.safelySetBankFor reg
	#else
		.setOrClearRpBit RP0, 0x0080
		.setOrClearRpBit RP1, 0x0100
	#endif

	.knownBank reg
	#endif
	endm

.trySetBankFor macro reg1, reg2
	#ifdef reg1
	.setBankFromEquFor reg1
	#else
	.setBankFromEquFor reg2
	#endif
	endm

.setBankFor macro reg
	.trySetBankFor BANK_FOR_#v(0)reg, reg
	endm

callProducesUnknownBank macro label
	CALL label
	.unknownBank
	endm

#define call callProducesUnknownBank

	#endif
