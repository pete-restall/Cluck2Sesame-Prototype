HEX_FILES=\
	EnableDisableSmpsTest.hex \
	EnableDisablePortTest.hex \
	IsShiftRegisterEnabledTest.hex

ENABLE_DISABLE_SMPS_OBJ_FILES=\
	EnableDisableSmpsTest.o \
	../../Smps/EnableDisableSmpsMocks.o \
	../../Smps/IsSmpsEnabledDummy.o \
	../../Smps/PollSmpsDummy.o

ENABLE_DISABLE_PORT_OBJ_FILES=\
	EnableDisablePortTest.o \
	../../Smps/EnableDisableSmpsDummies.o \
	../../Smps/PollSmpsDummy.o

IS_SHIFT_REGISTER_ENABLED_OBJ_FILES=\
	IsShiftRegisterEnabledTest.o \
	../../Smps/EnableSmpsDummy.o \
	../../Smps/DisableSmpsDummy.o \
	../../Smps/IsSmpsEnabledStub.o \
	../../Smps/PollSmpsDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

EnableDisableSmpsTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_OBJ_FILES)

EnableDisablePortTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_PORT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_PORT_OBJ_FILES)

IsShiftRegisterEnabledTest.hex: $(OBJ_FILES) $(IS_SHIFT_REGISTER_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_SHIFT_REGISTER_ENABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
