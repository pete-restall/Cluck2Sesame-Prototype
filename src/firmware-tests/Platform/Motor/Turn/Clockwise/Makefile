HEX_FILES=\
	PwmDutyCycleFromRestTest.hex \
	PulseSteeringFromRestTest.hex \
	PwmDutyCycleForReverseTest.hex \
	PulseSteeringForReverseTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../../../Smps/EnableSmpsDummy.o \
	../../../Smps/DisableSmpsDummy.o \
	../../../Smps/IsSmpsEnabledStub.o \
	../../../Smps/PollSmpsDummy.o \
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

include $(MAKEFILE_RULES)
