HEX_FILES=\
	ShiftRegisterEnabledNextStateTest.hex \
	ShiftRegisterDisabledNextStateTest.hex \
	EnableMotorVddWhenShiftRegisterEnabledTest.hex \
	EnableMotorVddWhenShiftRegisterDisabledTest.hex \
	EnableMotorVddCalledAfterShiftRegisterClearedTest.hex \
	ShiftRegisterNotClearedBeforeEnabledTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../../PollAfterLcdMock.o \
	../../AdcDummies.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/IsShiftRegisterEnabledStub.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/InitialiseShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/EnableShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/DisableShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftOutDummy.o

SHIFT_REGISTER_ENABLED_NEXT_STATE_OBJ_FILES=\
	ShiftRegisterEnabledNextStateTest.o \
	../../../Motor/MotorDummies.o \
	$(TEST_DOUBLE_OBJ_FILES)

SHIFT_REGISTER_DISABLED_NEXT_STATE_OBJ_FILES=\
	ShiftRegisterDisabledNextStateTest.o \
	../../../Motor/MotorDummies.o \
	$(TEST_DOUBLE_OBJ_FILES)

ENABLE_MOTOR_VDD_WHEN_SHIFT_REGISTER_ENABLED_OBJ_FILES=\
	EnableMotorVddWhenShiftRegisterEnabledTest.o \
	../../../Motor/InitialiseMotorDummy.o \
	../../../Motor/EnableMotorVddMock.o \
	../../../Motor/DisableMotorVddDummy.o \
	../../../Motor/IsMotorVddEnabledStub.o \
	../../../Motor/PollMotorDummy.o \
	../../../Motor/TurnMotorDummies.o \
	$(TEST_DOUBLE_OBJ_FILES)

ENABLE_MOTOR_VDD_WHEN_SHIFT_REGISTER_DISABLED_OBJ_FILES=\
	EnableMotorVddWhenShiftRegisterDisabledTest.o \
	../../../Motor/InitialiseMotorDummy.o \
	../../../Motor/EnableMotorVddMock.o \
	../../../Motor/DisableMotorVddDummy.o \
	../../../Motor/IsMotorVddEnabledStub.o \
	../../../Motor/PollMotorDummy.o \
	../../../Motor/TurnMotorDummies.o \
	$(TEST_DOUBLE_OBJ_FILES)

ENABLE_MOTOR_VDD_CALLED_AFTER_SHIFT_REGISTER_CLEARED_OBJ_FILES=\
	EnableMotorVddCalledAfterShiftRegisterClearedTest.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/IsShiftRegisterEnabledStub.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/InitialiseShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/EnableShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/DisableShiftRegisterDummy.o \
	../../AdcDummies.o \
	../../PollAfterLcdDummy.o \
	../../../Motor/InitialiseMotorDummy.o \
	../../../Motor/DisableMotorVddDummy.o \
	../../../Motor/IsMotorVddEnabledDummy.o \
	../../../Motor/PollMotorDummy.o \
	../../../Motor/TurnMotorDummies.o

SHIFT_REGISTER_NOT_CLEARED_BEFORE_ENABLED_OBJ_FILES=\
	ShiftRegisterNotClearedBeforeEnabledTest.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/IsShiftRegisterEnabledStub.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftOutMock.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/InitialiseShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/EnableShiftRegisterDummy.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/DisableShiftRegisterDummy.o \
	../../AdcDummies.o \
	../../PollAfterLcdDummy.o \
	../../../Motor/MotorDummies.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ShiftRegisterEnabledNextStateTest.hex: $(OBJ_FILES) $(SHIFT_REGISTER_ENABLED_NEXT_STATE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SHIFT_REGISTER_ENABLED_NEXT_STATE_OBJ_FILES)

ShiftRegisterDisabledNextStateTest.hex: $(OBJ_FILES) $(SHIFT_REGISTER_DISABLED_NEXT_STATE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SHIFT_REGISTER_DISABLED_NEXT_STATE_OBJ_FILES)

EnableMotorVddWhenShiftRegisterEnabledTest.hex: $(OBJ_FILES) $(ENABLE_MOTOR_VDD_WHEN_SHIFT_REGISTER_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_MOTOR_VDD_WHEN_SHIFT_REGISTER_ENABLED_OBJ_FILES)

EnableMotorVddWhenShiftRegisterDisabledTest.hex: $(OBJ_FILES) $(ENABLE_MOTOR_VDD_WHEN_SHIFT_REGISTER_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_MOTOR_VDD_WHEN_SHIFT_REGISTER_DISABLED_OBJ_FILES)

EnableMotorVddCalledAfterShiftRegisterClearedTest.hex: $(OBJ_FILES) $(ENABLE_MOTOR_VDD_CALLED_AFTER_SHIFT_REGISTER_CLEARED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_MOTOR_VDD_CALLED_AFTER_SHIFT_REGISTER_CLEARED_OBJ_FILES)

ShiftRegisterNotClearedBeforeEnabledTest.hex: $(OBJ_FILES) $(SHIFT_REGISTER_NOT_CLEARED_BEFORE_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SHIFT_REGISTER_NOT_CLEARED_BEFORE_ENABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
