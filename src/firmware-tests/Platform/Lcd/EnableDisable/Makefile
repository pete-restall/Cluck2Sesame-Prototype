ASARGS+=-I $(PLATFORM_DIR)/Lcd

HEX_FILES=\
	EnableDisableShiftRegisterTest.hex \
	StateAfterEnabledFirstTimeTest.hex \
	StateAfterEnabledSecondTimeTest.hex \
	StateAfterDisabledNotAsManyTimesAsEnabledTest.hex \
	StateAfterDisabledTest.hex \
	DisableAdcTest.hex \
	DisableAdcNotCalledWhenLcdStillEnabledTest.hex \
	DisableMotorVddTest.hex \
	IsLcdEnabledAfterLcdDisabledTest.hex \
	IsLcdEnabledAfterLcdNotDisabledTest.hex \
	ContrastPinAfterDisabledTest.hex \
	ContrastPinAfterNotDisabledTest.hex

SHIFT_REGISTER_DUMMY_OBJ_FILES=\
	$(PLATFORM_TESTS_DIR)/ShiftRegister/InitialiseShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/EnableShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/DisableShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/IsShiftRegisterEnabledStubbedTrue.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftOutDummy.o

OBJ_FILES+=\
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../PollAfterLcdDummy.o \
	../InitialiseAfterLcdDummy.o

ENABLE_DISABLE_SHIFT_REGISTER_OBJ_FILES=\
	EnableDisableShiftRegisterTest.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/EnableDisableShiftRegisterMocks.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/InitialiseShiftRegisterMock.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftOutMock.o \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	../AdcDummies.o

STATE_AFTER_ENABLED_FIRST_TIME_OBJ_FILES=\
	StateAfterEnabledFirstTimeTest.o \
	$(SHIFT_REGISTER_DUMMY_OBJ_FILES) \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	../AdcDummies.o

STATE_AFTER_ENABLED_SECOND_TIME_OBJ_FILES=\
	StateAfterEnabledSecondTimeTest.o \
	$(SHIFT_REGISTER_DUMMY_OBJ_FILES) \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	../AdcDummies.o

STATE_AFTER_DISABLED_NOT_AS_MANY_TIMES_AS_ENABLED_OBJ_FILES=\
	StateAfterDisabledNotAsManyTimesAsEnabledTest.o \
	$(SHIFT_REGISTER_DUMMY_OBJ_FILES) \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	../AdcDummies.o

STATE_AFTER_DISABLED_OBJ_FILES=\
	StateAfterDisabledTest.o \
	$(SHIFT_REGISTER_DUMMY_OBJ_FILES) \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	../AdcDummies.o

DISABLE_ADC_OBJ_FILES=\
	DisableAdcTest.o \
	$(SHIFT_REGISTER_DUMMY_OBJ_FILES) \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	../AdcMocks.o

DISABLE_ADC_NOT_CALLED_WHEN_LCD_STILL_ENABLED_OBJ_FILES=\
	DisableAdcNotCalledWhenLcdStillEnabledTest.o \
	$(SHIFT_REGISTER_DUMMY_OBJ_FILES) \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	../AdcMocks.o

DISABLE_MOTOR_VDD_OBJ_FILES=\
	DisableMotorVddTest.o \
	../AdcMocks.o \
	$(PLATFORM_TESTS_DIR)/Motor/DisableMotorVddMock.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/EnableDisableShiftRegisterMocks.o \
	$(PLATFORM_TESTS_DIR)/Motor/InitialiseMotorDummy.o \
	$(PLATFORM_TESTS_DIR)/Motor/EnableMotorVddDummy.o \
	$(PLATFORM_TESTS_DIR)/Motor/IsMotorVddEnabledDummy.o \
	$(PLATFORM_TESTS_DIR)/Motor/PollMotorDummy.o \
	$(PLATFORM_TESTS_DIR)/Motor/TurnMotorDummies.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/InitialiseShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftOutDummy.o

IS_LCD_ENABLED_AFTER_LCD_DISABLED_OBJ_FILES=\
	IsLcdEnabledAfterLcdDisabledTest.o \
	$(SHIFT_REGISTER_DUMMY_OBJ_FILES) \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	../AdcDummies.o

IS_LCD_ENABLED_AFTER_LCD_NOT_DISABLED_OBJ_FILES=\
	IsLcdEnabledAfterLcdNotDisabledTest.o \
	$(SHIFT_REGISTER_DUMMY_OBJ_FILES) \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	../AdcDummies.o

CONTRAST_PIN_AFTER_DISABLED_OBJ_FILES=\
	ContrastPinAfterDisabledTest.o \
	$(SHIFT_REGISTER_DUMMY_OBJ_FILES) \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	../AdcDummies.o

CONTRAST_PIN_AFTER_NOT_DISABLED_OBJ_FILES=\
	ContrastPinAfterNotDisabledTest.o \
	$(SHIFT_REGISTER_DUMMY_OBJ_FILES) \
	$(PLATFORM_TESTS_DIR)/Motor/MotorDummies.o \
	../AdcDummies.o

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

DisableMotorVddTest.hex: $(OBJ_FILES) $(DISABLE_MOTOR_VDD_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(DISABLE_MOTOR_VDD_OBJ_FILES)

IsLcdEnabledAfterLcdDisabledTest.hex: $(OBJ_FILES) $(IS_LCD_ENABLED_AFTER_LCD_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_LCD_ENABLED_AFTER_LCD_DISABLED_OBJ_FILES)

IsLcdEnabledAfterLcdNotDisabledTest.hex: $(OBJ_FILES) $(IS_LCD_ENABLED_AFTER_LCD_NOT_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_LCD_ENABLED_AFTER_LCD_NOT_DISABLED_OBJ_FILES)

ContrastPinAfterDisabledTest.hex: $(OBJ_FILES) $(CONTRAST_PIN_AFTER_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(CONTRAST_PIN_AFTER_DISABLED_OBJ_FILES)

ContrastPinAfterNotDisabledTest.hex: $(OBJ_FILES) $(CONTRAST_PIN_AFTER_NOT_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(CONTRAST_PIN_AFTER_NOT_DISABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
