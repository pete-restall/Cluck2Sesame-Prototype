ASARGS+=-I $(PLATFORM_DIR)/Lcd

HEX_FILES=\
	PutCharacterTest.hex

TEST_DOUBLE_OBJ_FILES=\
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../InitialiseAfterLcdDummy.o \
	../PollAfterLcdDummy.o \
	../AdcDummies.o \
	../ShiftRegisterDummies.o \
	../../Motor/MotorDummies.o

PUT_CHARACTER_OBJ_FILES=\
	PutCharacterTest.o \
	../WriteRegisterTestFixture.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PutCharacterTest.hex: $(OBJ_FILES) $(PUT_CHARACTER_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PUT_CHARACTER_OBJ_FILES)

include $(MAKEFILE_RULES)
