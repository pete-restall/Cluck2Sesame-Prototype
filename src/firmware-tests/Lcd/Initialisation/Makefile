ASARGS+=-I $(FIRMWARE_DIR)/Lcd

HEX_FILES=\
	InitialisationChainTest.hex \
	InitialStateTest.hex

INITIALISATION_CHAIN_OBJ_FILES=\
	InitialisationChainTest.o \
	../InitialiseShiftRegisterMock.o \
	../EnableDisableShiftRegisterMocks.o \
	../ShiftOutMock.o \
	../PollAfterLcdDummy.o

INITIAL_STATE_OBJ_FILES=\
	InitialStateTest.o \
	../ShiftRegisterDummies.o \
	../PollAfterLcdDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

InitialStateTest.hex: $(OBJ_FILES) $(INITIAL_STATE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIAL_STATE_OBJ_FILES)

include $(MAKEFILE_RULES)
