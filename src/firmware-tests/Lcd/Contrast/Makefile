HEX_FILES=\
	ContrastWhenLcdEnabledTest.hex \
	ContrastWhenLcdDisabledTest.hex \
	ContrastWhenLcdDisabledButAdcStillEnabledTest.hex

OBJ_FILES+=\
	$(FIRMWARE_DIR)/Adc.a \
	$(FIRMWARE_DIR)/Isr.o \
	$(FIRMWARE_DIR)/Clock.a \
	$(FIRMWARE_DIR)/Arithmetic4.o \
	$(FIRMWARE_DIR)/ArithmeticBcd.a

TEST_DOUBLE_OBJ_FILES=\
	../PollAfterLcdDummy.o \
	../InitialiseShiftRegisterDummy.o \
	../EnableShiftRegisterDummy.o \
	../DisableShiftRegisterDummy.o \
	../IsShiftRegisterEnabledStubbedTrue.o \
	../ShiftOutDummy.o \
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
