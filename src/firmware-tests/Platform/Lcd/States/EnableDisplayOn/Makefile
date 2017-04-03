HEX_FILES=\
	ShiftOutTest.hex \
	NextPollInChainTest.hex \
	NextStateTest.hex \
	IsLcdEnabledTest.hex

OBJ_FILES+=\
	../../AdcDummies.o \
	../../../Motor/MotorDummies.o

SHIFT_OUT_OBJ_FILES=\
	ShiftOutTest.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftOutMock.o \
	../../PollAfterLcdDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/InitialiseShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/EnableShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/DisableShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/IsShiftRegisterEnabledDummy.o

NEXT_POLL_IN_CHAIN_OBJ_FILES=\
	NextPollInChainTest.o \
	../../PollAfterLcdMock.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftRegisterDummies.o

NEXT_STATE_OBJ_FILES=\
	NextStateTest.o \
	../../PollAfterLcdDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftRegisterDummies.o

IS_LCD_ENABLED_OBJ_FILES=\
	IsLcdEnabledTest.o \
	../../PollAfterLcdDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftRegisterDummies.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ShiftOutTest.hex: $(OBJ_FILES) $(SHIFT_OUT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SHIFT_OUT_OBJ_FILES)

NextPollInChainTest.hex: $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_POLL_IN_CHAIN_OBJ_FILES)

NextStateTest.hex: $(OBJ_FILES) $(NEXT_STATE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEXT_STATE_OBJ_FILES)

IsLcdEnabledTest.hex: $(OBJ_FILES) $(IS_LCD_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_LCD_ENABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
