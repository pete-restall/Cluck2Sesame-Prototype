HEX_FILES=\
	PwmDutyCycleFromRestTest.hex

PWM_DUTY_CYCLE_FROM_REST_OBJ_FILES=\
	PwmDutyCycleFromRestTest.o \
	../PwmDutyCycleFromRestTestFixture.o \
	../../../Smps/EnableSmpsDummy.o \
	../../../Smps/DisableSmpsDummy.o \
	../../../Smps/IsSmpsEnabledStub.o \
	../../../Smps/PollSmpsDummy.o \
	../../PollAfterMotorDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PwmDutyCycleFromRestTest.hex: $(OBJ_FILES) $(PWM_DUTY_CYCLE_FROM_REST_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PWM_DUTY_CYCLE_FROM_REST_OBJ_FILES)

include $(MAKEFILE_RULES)
