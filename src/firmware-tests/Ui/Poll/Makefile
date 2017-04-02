HEX_FILES=\
	PollChainTest.hex

POLL_CHAIN_OBJ_FILES=\
	PollChainTest.o \
	../InitialiseAfterUiDummy.o \
	../PollAfterUiMock.o \
	$(PLATFORM_TESTS_DIR)/PowerManagement/PowerManagementDummies.o \
	$(PLATFORM_TESTS_DIR)/Lcd/LcdDummies.o \
	$(PLATFORM_TESTS_DIR)/Buttons/ButtonsDummies.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

PollChainTest.hex: $(OBJ_FILES) $(POLL_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(POLL_CHAIN_OBJ_FILES)

include $(MAKEFILE_RULES)
