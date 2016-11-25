HEX_FILES=\
	EnableDisableMotorVddTest.hex \
	EnableDisablePortTest.hex \
	IsShiftRegisterEnabledTest.hex

ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES=\
	EnableDisableMotorVddTest.o \
	../EnableDisableMotorVddMocks.o

ENABLE_DISABLE_PORT_OBJ_FILES=\
	EnableDisablePortTest.o \
	../EnableDisableMotorVddStubs.o

IS_SHIFT_REGISTER_ENABLED_OBJ_FILES=\
	IsShiftRegisterEnabledTest.o \
	../EnableMotorVddDummy.o \
	../DisableMotorVddDummy.o \
	../IsMotorVddEnabledStub.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

EnableDisableMotorVddTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES)

EnableDisablePortTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_PORT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_PORT_OBJ_FILES)

IsShiftRegisterEnabledTest.hex: $(OBJ_FILES) $(IS_SHIFT_REGISTER_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_SHIFT_REGISTER_ENABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
