HEX_FILES=\
	PollChainTest.hex

TEST_DOUBLE_OBJ_FILES=\
	$(PLATFORM_TESTS_DIR)/ShiftRegister/ShiftRegisterDummies.o

POLL_CHAIN_OBJ_FILES=\
	PollChainTest.o \
	$(TEST_DOUBLE_OBJ_FILES)

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PollChainTest.hex: $(OBJ_FILES) $(POLL_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(POLL_CHAIN_OBJ_FILES)

include $(MAKEFILE_RULES)
