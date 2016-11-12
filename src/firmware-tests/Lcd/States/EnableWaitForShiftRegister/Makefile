HEX_FILES=\
	ShiftRegisterEnabledTest.hex \
	ShiftRegisterDisabledTest.hex

OBJ_FILES+=\
	../../AdcDummies.o

TEST_DOUBLE_OBJ_FILES=\
	../../IsShiftRegisterEnabledStub.o \
	../../PollAfterLcdMock.o \
	../../InitialiseShiftRegisterDummy.o \
	../../EnableShiftRegisterDummy.o \
	../../DisableShiftRegisterDummy.o \
	../../ShiftOutDummy.o

SHIFT_REGISTER_ENABLED_OBJ_FILES=\
	ShiftRegisterEnabledTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

SHIFT_REGISTER_DISABLED_OBJ_FILES=\
	ShiftRegisterDisabledTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ShiftRegisterEnabledTest.hex: $(OBJ_FILES) $(SHIFT_REGISTER_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SHIFT_REGISTER_ENABLED_OBJ_FILES)

ShiftRegisterDisabledTest.hex: $(OBJ_FILES) $(SHIFT_REGISTER_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SHIFT_REGISTER_DISABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
