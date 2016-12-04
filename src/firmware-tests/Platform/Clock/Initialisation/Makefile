OBJ_FILES+=$(ASSERT_NO_ISR_OBJ_FILE)

HEX_FILES=\
	Timer1SourceIsExternalCrystalTest.hex \
	Timer1DrivesExternalCrystalTest.hex \
	Timer1PrescalerTest.hex \
	Timer1AsyncTest.hex \
	Timer1EnabledTest.hex \
	Timer1NotGatedTest.hex \
	ClockFlagsClearedTest.hex \
	InitialisationChainTest.hex \
	Timer1InterruptEnabledTest.hex

TIMER1_SOURCE_IS_EXTERNAL_CRYSTAL_OBJ_FILES=\
	Timer1SourceIsExternalCrystalTest.o

TIMER1_DRIVES_EXTERNAL_CRYSTAL_OBJ_FILES=\
	Timer1DrivesExternalCrystalTest.o

TIMER1_PRESCALER_OBJ_FILES=\
	Timer1PrescalerTest.o

TIMER1_ASYNC_OBJ_FILES=\
	Timer1AsyncTest.o

TIMER1_ENABLED_OBJ_FILES=\
	Timer1EnabledTest.o

TIMER1_NOT_GATED_OBJ_FILES=\
	Timer1NotGatedTest.o

CLOCK_FLAGS_CLEARED_OBJ_FILES=\
	ClockFlagsClearedTest.o

INITIALISATION_CHAIN_OBJ_FILES=\
	InitialisationChainTest.o

TIMER1_INTERRUPT_ENABLED_OBJ_FILES=\
	Timer1InterruptEnabledTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

Timer1SourceIsExternalCrystalTest.hex: $(OBJ_FILES) $(TIMER1_SOURCE_IS_EXTERNAL_CRYSTAL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(TIMER1_SOURCE_IS_EXTERNAL_CRYSTAL_OBJ_FILES)

Timer1DrivesExternalCrystalTest.hex: $(OBJ_FILES) $(TIMER1_DRIVES_EXTERNAL_CRYSTAL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(TIMER1_DRIVES_EXTERNAL_CRYSTAL_OBJ_FILES)

Timer1PrescalerTest.hex: $(OBJ_FILES) $(TIMER1_PRESCALER_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(TIMER1_PRESCALER_OBJ_FILES)

Timer1AsyncTest.hex: $(OBJ_FILES) $(TIMER1_ASYNC_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(TIMER1_ASYNC_OBJ_FILES)

Timer1EnabledTest.hex: $(OBJ_FILES) $(TIMER1_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(TIMER1_ENABLED_OBJ_FILES)

Timer1NotGatedTest.hex: $(OBJ_FILES) $(TIMER1_NOT_GATED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(TIMER1_NOT_GATED_OBJ_FILES)

ClockFlagsClearedTest.hex: $(OBJ_FILES) $(CLOCK_FLAGS_CLEARED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(CLOCK_FLAGS_CLEARED_OBJ_FILES)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

Timer1InterruptEnabledTest.hex: $(OBJ_FILES) $(TIMER1_INTERRUPT_ENABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(TIMER1_INTERRUPT_ENABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
