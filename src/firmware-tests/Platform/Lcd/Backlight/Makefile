ASARGS+=-I $(PLATFORM_DIR)/Lcd

HEX_FILES=\
	SetFlagShiftOutTest.hex \
	ClearFlagShiftOutTest.hex

TEST_DOUBLE_OBJ_FILES=\
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftRegisterDummies.o \
	../InitialiseAfterLcdDummy.o \
	../PollAfterLcdDummy.o \
	../AdcDummies.o \
	../../Motor/MotorDummies.o

SET_FLAG_SHIFT_OUT_OBJ_FILES=\
	SetFlagShiftOutTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

CLEAR_FLAG_SHIFT_OUT_OBJ_FILES=\
	ClearFlagShiftOutTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

SetFlagShiftOutTest.hex: $(OBJ_FILES) $(SET_FLAG_SHIFT_OUT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SET_FLAG_SHIFT_OUT_OBJ_FILES)

ClearFlagShiftOutTest.hex: $(OBJ_FILES) $(CLEAR_FLAG_SHIFT_OUT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(CLEAR_FLAG_SHIFT_OUT_OBJ_FILES)

include $(MAKEFILE_RULES)
