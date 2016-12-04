HEX_FILES=\
	InterruptEnableTest.hex \
	InitialPollBeforeLowPowerStateTest.hex

INTERRUPT_ENABLE_OBJ_FILES=\
	InterruptEnableTest.o \
	$(DUMMY_ISR_OBJ_FILE) \
	../ResetDummies.o \
	../../PowerManagement/PowerManagementDummies.o

INITIAL_POLL_BEFORE_LOW_POWER_STATE_OBJ_FILES=\
	InitialPollBeforeLowPowerStateTest.o \
	$(DUMMY_ISR_OBJ_FILE) \
	../ResetDummies.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InterruptEnableTest.hex: $(OBJ_FILES) $(INTERRUPT_ENABLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INTERRUPT_ENABLE_OBJ_FILES)

InitialPollBeforeLowPowerStateTest.hex: $(OBJ_FILES) $(INITIAL_POLL_BEFORE_LOW_POWER_STATE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIAL_POLL_BEFORE_LOW_POWER_STATE_OBJ_FILES)

include $(MAKEFILE_RULES)
