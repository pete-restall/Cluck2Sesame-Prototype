fcall macro destination
	local nextInstruction
	pagesel destination
	call destination
	pagesel nextInstruction
nextInstruction:
	endm

fgoto macro destination
	pagesel destination
	goto destination
	endm
