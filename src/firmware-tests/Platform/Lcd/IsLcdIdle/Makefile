ASARGS+=-I $(PLATFORM_DIR)/Lcd

HEX_FILES=\
	IsLcdIdleTest.hex

IS_LCD_IDLE_OBJ_FILES=\
	IsLcdIdleTest.o \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../InitialiseAfterLcdDummy.o \
	../PollAfterLcdDummy.o \
	../AdcDummies.o \
	../ShiftRegisterDummies.o \
	../../Motor/MotorDummies.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

IsLcdIdleTest.hex: $(OBJ_FILES) $(IS_LCD_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_LCD_IDLE_OBJ_FILES)

include $(MAKEFILE_RULES)
