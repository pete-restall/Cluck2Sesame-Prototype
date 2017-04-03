HEX_FILES=\
	MotorVddEnabledTest.hex \
	MotorVddDisabledTest.hex

OBJ_FILES+=\
	../../AdcDummies.o

TEST_DOUBLE_OBJ_FILES=\
	../../../Motor/InitialiseMotorDummy.o \
	../../../Motor/EnableMotorVddDummy.o \
	../../../Motor/DisableMotorVddDummy.o \
	../../../Motor/IsMotorVddEnabledStub.o \
	../../../Motor/PollMotorDummy.o \
	../../../Motor/TurnMotorDummies.o \
	../../PollAfterLcdMock.o \
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftRegisterDummies.o \

MOTOR_VDD_ENABLED_OBJ_FILES=\
	MotorVddEnabledTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

MOTOR_VDD_DISABLED_OBJ_FILES=\
	MotorVddDisabledTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

MotorVddEnabledTest.hex: $(OBJ_FILES) $(MOTOR_VDD_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(MOTOR_VDD_ENABLED_OBJ_FILES)

MotorVddDisabledTest.hex: $(OBJ_FILES) $(MOTOR_VDD_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(MOTOR_VDD_DISABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
