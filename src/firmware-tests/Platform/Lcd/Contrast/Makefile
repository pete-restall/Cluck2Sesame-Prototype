HEX_FILES=\
	ContrastWhenLcdEnabledTest.hex \
	ContrastWhenLcdDisabledTest.hex \
	ContrastWhenLcdDisabledButAdcStillEnabledTest.hex

OBJ_FILES+=\
	$(PLATFORM_DIR)/Adc.a \
	$(PLATFORM_DIR)/Isr.o \
	$(PLATFORM_DIR)/Clock.a \
	$(PLATFORM_DIR)/Arithmetic4.o \
	$(PLATFORM_DIR)/ArithmeticBcd.a

TEST_DOUBLE_OBJ_FILES=\
	../PollAfterLcdDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/InitialiseShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/EnableShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/DisableShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/IsShiftRegisterEnabledStubbedTrue.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftOutDummy.o \
	../../Motor/InitialiseMotorDummy.o \
	../../Motor/EnableMotorVddDummy.o \
	../../Motor/DisableMotorVddDummy.o \
	../../Motor/IsMotorVddEnabledDummy.o \
	../../Motor/TurnMotorDummies.o \
	../../Isr/InitialiseAfterIsrDummy.o \
	../../Adc/InitialiseAfterAdcDummy.o \
	../../Clock/PollAfterClockDummy.o

CONTRAST_WHEN_LCD_ENABLED_OBJ_FILES=\
	ContrastWhenLcdEnabledTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

CONTRAST_WHEN_LCD_DISABLED_OBJ_FILES=\
	ContrastWhenLcdDisabledTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

CONTRAST_WHEN_LCD_DISABLED_BUT_ADC_STILL_ENABLED_OBJ_FILES=\
	ContrastWhenLcdDisabledButAdcStillEnabledTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ContrastWhenLcdEnabledTest.hex: $(OBJ_FILES) $(CONTRAST_WHEN_LCD_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(CONTRAST_WHEN_LCD_ENABLED_OBJ_FILES)

ContrastWhenLcdDisabledTest.hex: $(OBJ_FILES) $(CONTRAST_WHEN_LCD_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(CONTRAST_WHEN_LCD_DISABLED_OBJ_FILES)

ContrastWhenLcdDisabledButAdcStillEnabledTest.hex: $(OBJ_FILES) $(CONTRAST_WHEN_LCD_DISABLED_BUT_ADC_STILL_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(CONTRAST_WHEN_LCD_DISABLED_BUT_ADC_STILL_ENABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
