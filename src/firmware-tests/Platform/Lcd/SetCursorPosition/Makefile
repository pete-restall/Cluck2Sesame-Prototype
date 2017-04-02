ASARGS+=-I $(PLATFORM_DIR)/Lcd

HEX_FILES=\
	SetCursorPositionTest.hex

TEST_DOUBLE_OBJ_FILES=\
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../InitialiseAfterLcdDummy.o \
	../PollAfterLcdDummy.o \
	../AdcDummies.o \
	../ShiftRegisterDummies.o \
	../../Motor/MotorDummies.o

SET_CURSOR_POSITION_OBJ_FILES=\
	SetCursorPositionTest.o \
	../WriteRegisterTestFixture.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

SetCursorPositionTest.hex: $(OBJ_FILES) $(SET_CURSOR_POSITION_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SET_CURSOR_POSITION_OBJ_FILES)

include $(MAKEFILE_RULES)
