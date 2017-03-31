HEX_FILES=\
	PwmDutyCycleFromRestTest.hex \
	PulseSteeringFromRestTest.hex \
	PwmDutyCycleForReverseTest.hex \
	PulseSteeringForReverseTest.hex \
	SetAdcChannelFromRestIsSuccessfulTest.hex \
	SetAdcChannelFromRestIsUnsuccessfulTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../../../Smps/EnableSmpsDummy.o \
	../../../Smps/DisableSmpsDummy.o \
	../../../Smps/IsSmpsEnabledStub.o \
	../../../Smps/PollSmpsDummy.o \
	../../../Adc/InitialiseAdcDummy.o \
	../../../Adc/EnableDisableAdcDummies.o \
	../../../Adc/ChannelStubs.o \
	../../PollAfterMotorDummy.o

PWM_DUTY_CYCLE_FROM_REST_OBJ_FILES=\
	PwmDutyCycleFromRestTest.o \
	../PwmDutyCycleFromRestTestFixture.o \
	$(TEST_DOUBLE_OBJ_FILES)

PULSE_STEERING_FROM_REST_OBJ_FILES=\
	PulseSteeringFromRestTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

PWM_DUTY_CYCLE_FOR_REVERSE_OBJ_FILES=\
	PwmDutyCycleForReverseTest.o \
	../PwmDutyCycleForReverseTestFixture.o \
	$(TEST_DOUBLE_OBJ_FILES)

PULSE_STEERING_FOR_REVERSE_OBJ_FILES=\
	PulseSteeringForReverseTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

SET_ADC_CHANNEL_FROM_REST_IS_SUCCESSFUL_OBJ_FILES=\
	SetAdcChannelFromRestIsSuccessfulTest.o \
	../SetAdcChannelFromRestIsSuccessfulTestFixture.o \
	$(TEST_DOUBLE_OBJ_FILES)

SET_ADC_CHANNEL_FROM_REST_IS_UNSUCCESSFUL_OBJ_FILES=\
	SetAdcChannelFromRestIsUnsuccessfulTest.o \
	../SetAdcChannelFromRestIsUnsuccessfulTestFixture.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PwmDutyCycleFromRestTest.hex: $(OBJ_FILES) $(PWM_DUTY_CYCLE_FROM_REST_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PWM_DUTY_CYCLE_FROM_REST_OBJ_FILES)

PulseSteeringFromRestTest.hex: $(OBJ_FILES) $(PULSE_STEERING_FROM_REST_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PULSE_STEERING_FROM_REST_OBJ_FILES)

PwmDutyCycleForReverseTest.hex: $(OBJ_FILES) $(PWM_DUTY_CYCLE_FOR_REVERSE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PWM_DUTY_CYCLE_FOR_REVERSE_OBJ_FILES)

PulseSteeringForReverseTest.hex: $(OBJ_FILES) $(PULSE_STEERING_FOR_REVERSE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PULSE_STEERING_FOR_REVERSE_OBJ_FILES)

SetAdcChannelFromRestIsSuccessfulTest.hex: $(OBJ_FILES) $(SET_ADC_CHANNEL_FROM_REST_IS_SUCCESSFUL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SET_ADC_CHANNEL_FROM_REST_IS_SUCCESSFUL_OBJ_FILES)

SetAdcChannelFromRestIsUnsuccessfulTest.hex: $(OBJ_FILES) $(SET_ADC_CHANNEL_FROM_REST_IS_UNSUCCESSFUL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SET_ADC_CHANNEL_FROM_REST_IS_UNSUCCESSFUL_OBJ_FILES)

include $(MAKEFILE_RULES)
