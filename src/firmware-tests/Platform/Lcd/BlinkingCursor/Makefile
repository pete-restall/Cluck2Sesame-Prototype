ASARGS+=-I $(PLATFORM_DIR)/Lcd

HEX_FILES=\
	EnableBlinkingCursorTest.hex \
	DisableBlinkingCursorTest.hex

TEST_DOUBLE_OBJ_FILES=\
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../InitialiseAfterLcdDummy.o \
	../PollAfterLcdDummy.o \
	../AdcDummies.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftRegisterDummies.o \
	../../Motor/MotorDummies.o

ENABLE_BLINKING_CURSOR_OBJ_FILES=\
	EnableBlinkingCursorTest.o \
	../WriteTestFixture.o \
	$(TEST_DOUBLE_OBJ_FILES)

DISABLE_BLINKING_CURSOR_OBJ_FILES=\
	DisableBlinkingCursorTest.o \
	../WriteTestFixture.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

EnableBlinkingCursorTest.hex: $(OBJ_FILES) $(ENABLE_BLINKING_CURSOR_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_BLINKING_CURSOR_OBJ_FILES)

DisableBlinkingCursorTest.hex: $(OBJ_FILES) $(DISABLE_BLINKING_CURSOR_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(DISABLE_BLINKING_CURSOR_OBJ_FILES)

include $(MAKEFILE_RULES)
