HEX_FILES=\
	BorPorBitsSetTest.hex \
	NonBorPorBitsUnmodifiedTest.hex

BOR_POR_BITS_SET_OBJ_FILES=\
	BorPorBitsSetTest.o

NON_BOR_POR_BITS_UNMODIFIED_OBJ_FILES=\
	NonBorPorBitsUnmodifiedTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

BorPorBitsSetTest.hex: $(OBJ_FILES) $(BOR_POR_BITS_SET_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(BOR_POR_BITS_SET_OBJ_FILES)

NonBorPorBitsUnmodifiedTest.hex: $(OBJ_FILES) $(NON_BOR_POR_BITS_UNMODIFIED_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NON_BOR_POR_BITS_UNMODIFIED_OBJ_FILES)

include $(MAKEFILE_RULES)
