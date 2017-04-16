ASARGS+=-I $(PLATFORM_DIR)/Motor

HEX_FILES=\
	SoftStopTest.hex \
	PulseSteeringTest.hex \
	ReleaseAdcChannelTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../../../Smps/EnableSmpsDummies.o \
	../../../Smps/DisableSmpsDummies.o \
	../../../Smps/IsSmpsEnabledStub.o \
	../../../Smps/PollSmpsDummy.o \
	../../../Adc/InitialiseAdcDummy.o \
	../../../Adc/EnableDisableAdcDummies.o \
	../../../Adc/ChannelMocks.o \
	../../PollAfterMotorDummy.o

SOFT_STOP_OBJ_FILES=\
	SoftStopTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

PULSE_STEERING_OBJ_FILES=\
	PulseSteeringTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

RELEASE_ADC_CHANNEL_OBJ_FILES=\
	ReleaseAdcChannelTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

SoftStopTest.hex: $(OBJ_FILES) $(SOFT_STOP_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SOFT_STOP_OBJ_FILES)

PulseSteeringTest.hex: $(OBJ_FILES) $(PULSE_STEERING_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PULSE_STEERING_OBJ_FILES)

ReleaseAdcChannelTest.hex: $(OBJ_FILES) $(RELEASE_ADC_CHANNEL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(RELEASE_ADC_CHANNEL_OBJ_FILES)

include $(MAKEFILE_RULES)
