HEX_FILES=\
	BorPorBitsSetTest.hex \
	BorDisabledTest.hex \
	UlpwuDisabledTest.hex

BOR_POR_BITS_SET_OBJ_FILES=\
	BorPorBitsSetTest.o \
	$(PLATFORM_TESTS_DIR)/InitialiseAfterResetDummy.o

BOR_DISABLED_OBJ_FILES=\
	BorDisabledTest.o \
	$(PLATFORM_TESTS_DIR)/InitialiseAfterResetDummy.o

ULPWU_DISABLED_OBJ_FILES=\
	UlpwuDisabledTest.o \
	$(PLATFORM_TESTS_DIR)/InitialiseAfterResetDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

BorPorBitsSetTest.hex: $(OBJ_FILES) $(BOR_POR_BITS_SET_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(BOR_POR_BITS_SET_OBJ_FILES)

BorDisabledTest.hex: $(OBJ_FILES) $(BOR_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(BOR_DISABLED_OBJ_FILES)

UlpwuDisabledTest.hex: $(OBJ_FILES) $(ULPWU_DISABLED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ULPWU_DISABLED_OBJ_FILES)

include $(MAKEFILE_RULES)
