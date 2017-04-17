HEX_FILES=\
	EnableDisableSmpsTest.hex \
	EnableDisableSmpsHighPowerModeTest.hex \
	EnableDisableSmpsRmwTest.hex \
	EnableDisableSmpsHighPowerModeRmwTest.hex \
	EnableDisableSmpsShiftOutTest.hex \
	EnableDisableSmpsHighPowerModeShiftOutTest.hex \
	IsEnabledAfterInitialisationTest.hex \
	IsEnabledImmediatelyAfterEnableCallTest.hex \
	IsEnabledAfterDelayTest.hex \
	IsEnabledPowerManagementTest.hex \
	IsEnabledAfterDisabledTest.hex \
	EnableSmpsPicVddTest.hex \
	DisableSmpsPicVddTest.hex

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

IS_ENABLED_IMMEDIATELY_AFTER_ENABLE_CALL_OBJ_FILES=\
	IsEnabledImmediatelyAfterEnableCallTest.o \
	../../ShiftRegister/ShiftRegisterDummies.o

IS_ENABLED_AFTER_DELAY_OBJ_FILES=\
	IsEnabledAfterDelayTest.o \
	../../ShiftRegister/ShiftRegisterDummies.o

IS_ENABLED_POWER_MANAGEMENT_OBJ_FILES=\
	IsEnabledPowerManagementTest.o \
	../../ShiftRegister/ShiftRegisterDummies.o

IS_ENABLED_AFTER_DISABLED_OBJ_FILES=\
	IsEnabledAfterDisabledTest.o \
	../../ShiftRegister/ShiftRegisterDummies.o

ENABLE_SMPS_PIC_VDD_OBJ_FILES=\
	EnableSmpsPicVddTest.o \
	../../ShiftRegister/ShiftRegisterDummies.o

DISABLE_SMPS_PIC_VDD_OBJ_FILES=\
	DisableSmpsPicVddTest.o \
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

IsEnabledImmediatelyAfterEnableCallTest.hex: $(OBJ_FILES) $(IS_ENABLED_IMMEDIATELY_AFTER_ENABLE_CALL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_ENABLED_IMMEDIATELY_AFTER_ENABLE_CALL_OBJ_FILES)

IsEnabledAfterDelayTest.hex: $(OBJ_FILES) $(IS_ENABLED_AFTER_DELAY_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_ENABLED_AFTER_DELAY_OBJ_FILES)

IsEnabledPowerManagementTest.hex: $(OBJ_FILES) $(IS_ENABLED_POWER_MANAGEMENT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_ENABLED_POWER_MANAGEMENT_OBJ_FILES)

IsEnabledAfterDisabledTest.hex: $(OBJ_FILES) $(IS_ENABLED_AFTER_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_ENABLED_AFTER_DISABLED_OBJ_FILES)

EnableSmpsPicVddTest.hex: $(OBJ_FILES) $(ENABLE_SMPS_PIC_VDD_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENABLE_SMPS_PIC_VDD_OBJ_FILES)

DisableSmpsPicVddTest.hex: $(OBJ_FILES) $(DISABLE_SMPS_PIC_VDD_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(DISABLE_SMPS_PIC_VDD_OBJ_FILES)

include $(MAKEFILE_RULES)
