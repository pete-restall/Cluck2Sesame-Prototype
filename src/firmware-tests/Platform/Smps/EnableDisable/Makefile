HEX_FILES=\
	EnableDisableSmpsTest.hex \
	EnableDisableSmpsHighPowerModeTest.hex \
	EnableDisableSmpsRmwTest.hex \
	EnableDisableSmpsHighPowerModeRmwTest.hex \
	EnableDisableSmpsShiftOutTest.hex \
	EnableDisableSmpsHighPowerModeShiftOutTest.hex \
	IsEnabledAfterInitialisationTest.hex

TEST_FIXTURE_OBJ_FILES=\
	EnableDisableSmpsTestFixture.o \
	EnableDisableSmpsRmwTestFixture.o \
	EnableDisableSmpsShiftOutTestFixture.o

ENABLE_DISABLE_SMPS_OBJ_FILES=\
	EnableDisableSmpsTest.o \
	EnableDisableSmpsTestFixture.o \
	../../ShiftRegister/ShiftRegisterDummies.o

ENABLE_DISABLE_SMPS_HIGH_POWER_MODE_OBJ_FILES=\
	EnableDisableSmpsHighPowerModeTest.o \
	EnableDisableSmpsTestFixture.o \
	../../ShiftRegister/ShiftRegisterDummies.o

ENABLE_DISABLE_SMPS_RMW_OBJ_FILES=\
	EnableDisableSmpsRmwTest.o \
	EnableDisableSmpsRmwTestFixture.o \
	../../ShiftRegister/ShiftRegisterDummies.o

ENABLE_DISABLE_SMPS_HIGH_POWER_MODE_RMW_OBJ_FILES=\
	EnableDisableSmpsHighPowerModeRmwTest.o \
	EnableDisableSmpsRmwTestFixture.o \
	../../ShiftRegister/ShiftRegisterDummies.o

ENABLE_DISABLE_SMPS_SHIFT_OUT_OBJ_FILES=\
	EnableDisableSmpsShiftOutTest.o \
	EnableDisableSmpsShiftOutTestFixture.o \
	../../ShiftRegister/ShiftOutMock.o \
	../../ShiftRegister/IsShiftRegisterEnabledStub.o \
	../../ShiftRegister/InitialiseShiftRegisterDummy.o \
	../../ShiftRegister/EnableShiftRegisterDummy.o \
	../../ShiftRegister/DisableShiftRegisterDummy.o

ENABLE_DISABLE_SMPS_HIGH_POWER_MODE_SHIFT_OUT_OBJ_FILES=\
	EnableDisableSmpsHighPowerModeShiftOutTest.o \
	EnableDisableSmpsShiftOutTestFixture.o \
	../../ShiftRegister/ShiftOutMock.o \
	../../ShiftRegister/IsShiftRegisterEnabledStub.o \
	../../ShiftRegister/InitialiseShiftRegisterDummy.o \
	../../ShiftRegister/EnableShiftRegisterDummy.o \
	../../ShiftRegister/DisableShiftRegisterDummy.o

IS_ENABLED_AFTER_INITIALISATION_OBJ_FILES=\
	IsEnabledAfterInitialisationTest.o \
	../../ShiftRegister/ShiftRegisterDummies.o

all: $(TEST_FIXTURE_OBJ_FILES) $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

EnableDisableSmpsTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_OBJ_FILES)

EnableDisableSmpsHighPowerModeTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_HIGH_POWER_MODE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_HIGH_POWER_MODE_OBJ_FILES)

EnableDisableSmpsRmwTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_RMW_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_RMW_OBJ_FILES)

EnableDisableSmpsHighPowerModeRmwTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_HIGH_POWER_MODE_RMW_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_HIGH_POWER_MODE_RMW_OBJ_FILES)

EnableDisableSmpsShiftOutTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_SHIFT_OUT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_SHIFT_OUT_OBJ_FILES)

EnableDisableSmpsHighPowerModeShiftOutTest.hex: $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_HIGH_POWER_MODE_SHIFT_OUT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_DISABLE_SMPS_HIGH_POWER_MODE_SHIFT_OUT_OBJ_FILES)

IsEnabledAfterInitialisationTest.hex: $(OBJ_FILES) $(IS_ENABLED_AFTER_INITIALISATION_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_ENABLED_AFTER_INITIALISATION_OBJ_FILES)

include $(MAKEFILE_RULES)
