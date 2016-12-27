ASARGS+=-I $(PLATFORM_DIR)/Cordic

HEX_FILES=\
	InitialisationChainTest.hex \
	InitialStateTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../PollAfterCordicDummy.o

INITIALISATION_CHAIN_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	../InitialiseAfterCordicMock.o \
	InitialisationChainTest.o

INITIAL_STATE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	../InitialiseAfterCordicDummy.o \
	InitialStateTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

InitialStateTest.hex: $(OBJ_FILES) $(INITIAL_STATE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIAL_STATE_OBJ_FILES)

include $(MAKEFILE_RULES)
