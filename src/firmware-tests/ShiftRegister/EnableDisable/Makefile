HEX_FILES=\
	EnableDisableMotorVddTest.hex

ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES=\
	EnableDisableMotorVddTest.o \
	../EnableDisableMotorVddMocks.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

EnableDisableMotorVddTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_MOTOR_VDD_OBJ_FILES)

include $(MAKEFILE_RULES)
