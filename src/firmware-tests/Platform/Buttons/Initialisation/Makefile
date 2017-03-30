HEX_FILES=\
	InitialisationChainTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../PollAfterButtonsMock.o

INITIALISATION_CHAIN_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	InitialisationChainTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

include $(MAKEFILE_RULES)
