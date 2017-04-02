LIB_FILENAME=../Lcd.a
OBJ_FILES=\
	Registers.o \
	Initialise.o \
	EnableDisable.o \
	Poll.o \
	DisabledState.o \
	EnableWaitForShiftRegisterState.o \
	EnableWaitForMotorVddState.o \
	EnableWaitForMoreThan40msState.o \
	EnableTrySetByteMode1State.o \
	EnableTrySetByteMode2State.o \
	EnableSetByteModeState.o \
	EnableSetNibbleModeState.o \
	EnableSetDisplayState.o \
	EnableDisplayOffState.o \
	DisplayClearState.o \
	EnableEntryModeState.o \
	EnableSetContrastState.o \
	EnableDisplayOnState.o \
	WaitState.o \
	IdleState.o \
	Write.o \
	PutScreenFromFlash.o \
	PutCharacters.o \
	SetCharacterPosition.o \
	BlinkingCursor.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
