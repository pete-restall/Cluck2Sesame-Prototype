HEX_FILES=\
	InitialisationChainTest.hex \
	InitialiseTimer0Test.hex \
	ElapsedTicksTest.hex

OBJ_FILES=\
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	InitialiseAfterTimer0Mock.o \
	$(PLATFORM_DIR)/Timer0.o

INITIALISATION_CHAIN_OBJ_FILES=\
	InitialisationChainTest.o

INITIALISE_TIMER0_OBJ_FILES=\
	InitialiseTimer0Test.o

ELAPSED_TICKS_OBJ_FILES=\
	ElapsedTicksTest.o

all: $(HEX_FILES) InitialiseAfterTimer0Mock.o

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialisationChainTest.hex: $(INITIALISATION_CHAIN_OBJ_FILES) $(OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(INITIALISATION_CHAIN_OBJ_FILES) $(OBJ_FILES)

InitialiseTimer0Test.hex: $(INITIALISE_TIMER0_OBJ_FILES) $(OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(INITIALISE_TIMER0_OBJ_FILES) $(OBJ_FILES)

ElapsedTicksTest.hex: $(ELAPSED_TICKS_OBJ_FILES) $(OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(ELAPSED_TICKS_OBJ_FILES) $(OBJ_FILES)

include $(MAKEFILE_RULES)
