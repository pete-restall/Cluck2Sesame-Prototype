ASARGS+=-I $(FIRMWARE_DIR)/Lcd

HEX_FILES=\
	EnableDisableShiftRegisterTest.hex \
	StateAfterEnabledFirstTimeTest.hex \
	StateAfterEnabledSecondTimeTest.hex \
	StateAfterDisabledNotAsManyTimesAsEnabledTest.hex \
	StateAfterDisabledTest.hex \
	DisableAdcTest.hex \
	DisableAdcNotCalledWhenLcdStillEnabledTest.hex

OBJ_FILES+=\
	../PollAfterLcdDummy.o \
	../InitialiseAfterLcdDummy.o \
	$(ASSERT_NO_ISR_OBJ_FILE)

ENABLE_DISABLE_SHIFT_REGISTER_OBJ_FILES=\
	EnableDisableShiftRegisterTest.o \
	../EnableDisableShiftRegisterMocks.o \
	../InitialiseShiftRegisterMock.o \
	../ShiftOutMock.o \
	../AdcDummies.o

STATE_AFTER_ENABLED_FIRST_TIME_OBJ_FILES=\
	StateAfterEnabledFirstTimeTest.o \
	../ShiftRegisterDummies.o \
	../AdcDummies.o

STATE_AFTER_ENABLED_SECOND_TIME_OBJ_FILES=\
	StateAfterEnabledSecondTimeTest.o \
	../ShiftRegisterDummies.o \
	../AdcDummies.o

STATE_AFTER_DISABLED_NOT_AS_MANY_TIMES_AS_ENABLED_OBJ_FILES=\
	StateAfterDisabledNotAsManyTimesAsEnabledTest.o \
	../ShiftRegisterDummies.o \
	../AdcDummies.o

STATE_AFTER_DISABLED_OBJ_FILES=\
	StateAfterDisabledTest.o \
	../ShiftRegisterDummies.o \
	../AdcDummies.o

DISABLE_ADC_OBJ_FILES=\
	DisableAdcTest.o \
	../ShiftRegisterDummies.o \
	../AdcMocks.o

DISABLE_ADC_NOT_CALLED_WHEN_LCD_STILL_ENABLED_OBJ_FILES=\
	DisableAdcNotCalledWhenLcdStillEnabledTest.o \
	../ShiftRegisterDummies.o \
	../AdcMocks.o

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

DisableAdcTest.hex: $(OBJ_FILES) $(DISABLE_ADC_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(DISABLE_ADC_OBJ_FILES)

DisableAdcNotCalledWhenLcdStillEnabledTest.hex: $(OBJ_FILES) $(DISABLE_ADC_NOT_CALLED_WHEN_LCD_STILL_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(DISABLE_ADC_NOT_CALLED_WHEN_LCD_STILL_ENABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
