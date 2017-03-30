HEX_FILES=\
	PollChainTest.hex

POLL_CHAIN_OBJ_FILES=\
	PollChainTest.o \
	../PollAfterButtonsMock.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PollChainTest.hex: $(OBJ_FILES) $(POLL_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(POLL_CHAIN_OBJ_FILES)

include $(MAKEFILE_RULES)
