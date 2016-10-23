HEX_FILES=\
	EnableDisableMotorVddTest.hex \
	EnableDisableSmpsTest.hex \
	EnableDisableSmpsOrderTest.hex

ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES=\
	EnableDisableMotorVddTest.o \
	../EnableDisableSmpsMocks.o \
	../PollSmpsDummy.o \
	../PollAfterMotorMock.o

ENABLE_DISABLE_SMPS_OBJ_FILES=\
	EnableDisableSmpsTest.o \
	../EnableDisableSmpsMocks.o \
	../PollSmpsDummy.o \
	../PollAfterMotorMock.o

ENABLE_DISABLE_SMPS_ORDER_OBJ_FILES=\
	EnableDisableSmpsOrderTest.o \
	../EnableDisableSmpsMocks.o \
	../PollSmpsDummy.o \
	../PollAfterMotorMock.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

EnableDisableMotorVddTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES)

EnableDisableSmpsTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_OBJ_FILES)

EnableDisableSmpsOrderTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_ORDER_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_ORDER_OBJ_FILES)

include $(MAKEFILE_RULES)
