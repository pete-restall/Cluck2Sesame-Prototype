HEX_FILES=\
	EnableDisableMotorVddTest.hex \
	EnableDisableMotorVddRmwTest.hex \
	EnableDisableSmpsTest.hex \
	EnableDisableSmpsOrderTest.hex \
	IsEnabledTest.hex \
	MotorStateTest.hex \
	EnableForSecondTimeWhenMotorStateNotIdleTest.hex \
	EnableForFirstTimeWhenMotorStateNotDisabledTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../../Smps/EnableDisableSmpsMocks.o \
	../../Smps/IsSmpsEnabledStub.o \
	../../Smps/PollSmpsDummy.o \
	../../Adc/AdcDummies.o \
	../PollAfterMotorMock.o

ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES=\
	EnableDisableMotorVddTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

ENABLE_DISABLE_MOTOR_VDD_RMW_OBJ_FILES=\
	EnableDisableMotorVddRmwTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

ENABLE_DISABLE_SMPS_OBJ_FILES=\
	EnableDisableSmpsTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

ENABLE_DISABLE_SMPS_ORDER_OBJ_FILES=\
	EnableDisableSmpsOrderTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

IS_ENABLED_OBJ_FILES=\
	IsEnabledTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

MOTOR_STATE_OBJ_FILES=\
	MotorStateTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

ENABLE_FOR_SECOND_TIME_WHEN_MOTOR_STATE_NOT_IDLE_OBJ_FILES=\
	EnableForSecondTimeWhenMotorStateNotIdleTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

ENABLE_FOR_FIRST_TIME_WHEN_MOTOR_STATE_NOT_DISABLED_OBJ_FILES=\
	EnableForFirstTimeWhenMotorStateNotDisabledTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

EnableDisableMotorVddTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES)

EnableDisableMotorVddRmwTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_MOTOR_VDD_RMW_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_MOTOR_VDD_RMW_OBJ_FILES)

EnableDisableSmpsTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_OBJ_FILES)

EnableDisableSmpsOrderTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_ORDER_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_ORDER_OBJ_FILES)

IsEnabledTest.hex: $(OBJ_FILES) $(IS_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_ENABLED_OBJ_FILES)

MotorStateTest.hex: $(OBJ_FILES) $(MOTOR_STATE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(MOTOR_STATE_OBJ_FILES)

EnableForSecondTimeWhenMotorStateNotIdleTest.hex: $(OBJ_FILES) $(ENABLE_FOR_SECOND_TIME_WHEN_MOTOR_STATE_NOT_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_FOR_SECOND_TIME_WHEN_MOTOR_STATE_NOT_IDLE_OBJ_FILES)

EnableForFirstTimeWhenMotorStateNotDisabledTest.hex: $(OBJ_FILES) $(ENABLE_FOR_FIRST_TIME_WHEN_MOTOR_STATE_NOT_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_FOR_FIRST_TIME_WHEN_MOTOR_STATE_NOT_DISABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
