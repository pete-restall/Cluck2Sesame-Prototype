HEX_FILES=\
	EnableDisableMotorVddTest.hex \
	EnableDisableMotorVddRmwTest.hex \
	EnableDisableSmpsTest.hex \
	EnableDisableSmpsOrderTest.hex \
	IsEnabledTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../EnableDisableSmpsMocks.o \
	../IsSmpsEnabledStub.o \
	../PollSmpsDummy.o \
	../PollAfterMotorMock.o

ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	EnableDisableMotorVddTest.o

ENABLE_DISABLE_MOTOR_VDD_RMW_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	EnableDisableMotorVddRmwTest.o

ENABLE_DISABLE_SMPS_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	EnableDisableSmpsTest.o

ENABLE_DISABLE_SMPS_ORDER_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	EnableDisableSmpsOrderTest.o

IS_ENABLED_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	IsEnabledTest.o

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

include $(MAKEFILE_RULES)
