HEX_FILES=\
	InitialisationChainTest.hex \
	InitialiseTimer0Test.hex

TEST_DOUBLE_OBJ_FILES=\
	../InitialiseAfterTimer0Mock.o \
	../PollAfterTimer0Dummy.o

INITIALISATION_CHAIN_OBJ_FILES=\
	InitialisationChainTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

INITIALISE_TIMER0_OBJ_FILES=\
	InitialiseTimer0Test.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialisationChainTest.hex: $(INITIALISATION_CHAIN_OBJ_FILES) $(OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(INITIALISATION_CHAIN_OBJ_FILES) $(OBJ_FILES)

InitialiseTimer0Test.hex: $(INITIALISE_TIMER0_OBJ_FILES) $(OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(INITIALISE_TIMER0_OBJ_FILES) $(OBJ_FILES)

include $(MAKEFILE_RULES)
