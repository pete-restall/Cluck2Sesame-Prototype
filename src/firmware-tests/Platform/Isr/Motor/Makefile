HEX_FILES=\
	FlagsTest.hex \
	NonMotorAdcChannelTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../InitialiseAfterIsrDummy.o \
	../ClockDummies.o \
	../../PowerManagement/PowerManagementDummies.o \
	../../Smps/SmpsDummies.o \
	$(PLATFORM_DIR)/Adc.a

FLAGS_OBJ_FILES=\
	FlagsTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

NON_MOTOR_ADC_CHANNEL_OBJ_FILES=\
	NonMotorAdcChannelTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

FlagsTest.hex: $(OBJ_FILES) $(FLAGS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(FLAGS_OBJ_FILES)

NonMotorAdcChannelTest.hex: $(OBJ_FILES) $(NON_MOTOR_ADC_CHANNEL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NON_MOTOR_ADC_CHANNEL_OBJ_FILES)

include $(MAKEFILE_RULES)
