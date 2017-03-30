HEX_FILES=\
	SoftStopTest.hex \
	PulseSteeringTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../../../Smps/EnableSmpsDummy.o \
	../../../Smps/DisableSmpsDummy.o \
	../../../Smps/IsSmpsEnabledStub.o \
	../../../Smps/PollSmpsDummy.o \
	../../PollAfterMotorDummy.o

SOFT_STOP_OBJ_FILES=\
	SoftStopTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

PULSE_STEERING_OBJ_FILES=\
	PulseSteeringTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

SoftStopTest.hex: $(OBJ_FILES) $(SOFT_STOP_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SOFT_STOP_OBJ_FILES)

PulseSteeringTest.hex: $(OBJ_FILES) $(PULSE_STEERING_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PULSE_STEERING_OBJ_FILES)

include $(MAKEFILE_RULES)
