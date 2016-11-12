HEX_FILES=\
	ShiftOutTest.hex \
	NextPollInChainTest.hex \
	NextStateTest.hex

OBJ_FILES+=\
	../../AdcDummies.o

SHIFT_OUT_OBJ_FILES=\
	ShiftOutTest.o \
	../../ShiftOutMock.o \
	../../PollAfterLcdDummy.o \
	../../InitialiseShiftRegisterDummy.o \
	../../EnableShiftRegisterDummy.o \
	../../DisableShiftRegisterDummy.o \
	../../IsShiftRegisterEnabledDummy.o

NEXT_POLL_IN_CHAIN_OBJ_FILES=\
	NextPollInChainTest.o \
	../../PollAfterLcdMock.o \
	../../ShiftRegisterDummies.o

NEXT_STATE_OBJ_FILES=\
	NextStateTest.o \
	../../PollAfterLcdDummy.o \
	../../ShiftRegisterDummies.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ShiftOutTest.hex: $(OBJ_FILES) $(SHIFT_OUT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SHIFT_OUT_OBJ_FILES)

NextPollInChainTest.hex: $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)

NextStateTest.hex: $(OBJ_FILES) $(NEXT_STATE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_STATE_OBJ_FILES)

include $(MAKEFILE_RULES)
