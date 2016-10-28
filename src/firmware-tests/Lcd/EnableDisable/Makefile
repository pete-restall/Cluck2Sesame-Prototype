ASARGS+=-I $(FIRMWARE_DIR)/Lcd

HEX_FILES=\
	EnableDisableShiftRegisterTest.hex \
	StateAfterEnabledFirstTimeTest.hex \
	StateAfterEnabledSecondTimeTest.hex \
	StateAfterDisabledNotAsManyTimesAsEnabledTest.hex \
	StateAfterDisabledTest.hex

ENABLE_DISABLE_SHIFT_REGISTER_OBJ_FILES=\
	EnableDisableShiftRegisterTest.o \
	../EnableDisableShiftRegisterMocks.o \
	../InitialiseShiftRegisterMock.o \
	../ShiftOutMock.o

STATE_AFTER_ENABLED_FIRST_TIME_OBJ_FILES=\
	StateAfterEnabledFirstTimeTest.o \
	../ShiftRegisterDummies.o

STATE_AFTER_ENABLED_SECOND_TIME_OBJ_FILES=\
	StateAfterEnabledSecondTimeTest.o \
	../ShiftRegisterDummies.o

STATE_AFTER_DISABLED_NOT_AS_MANY_TIMES_AS_ENABLED_OBJ_FILES=\
	StateAfterDisabledNotAsManyTimesAsEnabledTest.o \
	../ShiftRegisterDummies.o

STATE_AFTER_DISABLED_OBJ_FILES=\
	StateAfterDisabledTest.o \
	../ShiftRegisterDummies.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

EnableDisableShiftRegisterTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SHIFT_REGISTER_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SHIFT_REGISTER_OBJ_FILES)

StateAfterEnabledFirstTimeTest.hex: $(OBJ_FILES) $(STATE_AFTER_ENABLED_FIRST_TIME_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(STATE_AFTER_ENABLED_FIRST_TIME_OBJ_FILES)

StateAfterEnabledSecondTimeTest.hex: $(OBJ_FILES) $(STATE_AFTER_ENABLED_SECOND_TIME_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(STATE_AFTER_ENABLED_SECOND_TIME_OBJ_FILES)

StateAfterDisabledNotAsManyTimesAsEnabledTest.hex: $(OBJ_FILES) $(STATE_AFTER_DISABLED_NOT_AS_MANY_TIMES_AS_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(STATE_AFTER_DISABLED_NOT_AS_MANY_TIMES_AS_ENABLED_OBJ_FILES)

StateAfterDisabledTest.hex: $(OBJ_FILES) $(STATE_AFTER_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(STATE_AFTER_DISABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
