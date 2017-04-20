ASARGS+=-I $(PLATFORM_DIR)/Lcd

HEX_FILES=\
	PutCharacterTest.hex \
	PutBcdDigitsTest.hex

TEST_DOUBLE_OBJ_FILES=\
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../InitialiseAfterLcdDummy.o \
	../PollAfterLcdDummy.o \
	../AdcDummies.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftRegisterDummies.o \
	../../Motor/MotorDummies.o

PUT_CHARACTER_OBJ_FILES=\
	PutCharacterTest.o \
	../WriteTestFixture.o \
	$(TEST_DOUBLE_OBJ_FILES)

PUT_BCD_DIGITS_OBJ_FILES=\
	PutBcdDigitsTest.o \
	../DoubleWriteTestFixture.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PutCharacterTest.hex: $(OBJ_FILES) $(PUT_CHARACTER_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PUT_CHARACTER_OBJ_FILES)

PutBcdDigitsTest.hex: $(OBJ_FILES) $(PUT_BCD_DIGITS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PUT_BCD_DIGITS_OBJ_FILES)

include $(MAKEFILE_RULES)
