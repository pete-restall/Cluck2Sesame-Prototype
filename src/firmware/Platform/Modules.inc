	#ifndef __CLUCK2SESAME_PLATFORM_MODULES_INC
	#define __CLUCK2SESAME_PLATFORM_MODULES_INC

	radix decimal

BANK0 equ 0
BANK1 equ 1
BANK2 equ 2
BANK3 equ 3

	variable moduleIndex = 0

.defineModule macro name, bank
name equ moduleIndex
MODULE_#v(name)_BANK equ bank
moduleIndex = moduleIndex + 1
	endm

.module macro name
	variable moduleName = name
	endm

.externalVariableIn macro module, label
BANK_FOR_#v(0)label equ MODULE_#v(module)_BANK << 7
	extern label
	endm

.externalVariable macro label
	.externalVariableIn moduleName, label
	endm

	#endif
