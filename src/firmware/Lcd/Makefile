LIB_FILENAME=../Lcd.a
OBJ_FILES=\
	Initialise.o \
	EnableDisable.o \
	Poll.o \
	DisabledState.o \
	EnableWaitForShiftRegisterState.o \
	EnableWaitForMoreThan40msState.o \
	EnableTrySetByteMode1State.o \
	EnableTrySetByteMode2State.o \
	EnableSetByteModeState.o \
	EnableSetNibbleModeState.o \
	EnableSetDisplayState.o \
	EnableDisplayOffState.o \
	EnableDisplayClearState.o \
	EnableEntryModeState.o \
	EnableSetContrastState.o \
	EnableDisplayOnState.o \
	WaitState.o \
	IdleState.o \
	Write.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
