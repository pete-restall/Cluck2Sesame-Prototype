HEX_FILES=\
	NegateATest.hex \
	NegateBTest.hex

NEGATE_A_OBJ_FILES=\
	NegateATest.o

NEGATE_B_OBJ_FILES=\
	NegateBTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

NegateATest.hex: $(OBJ_FILES) $(NEGATE_A_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEGATE_A_OBJ_FILES)

NegateBTest.hex: $(OBJ_FILES) $(NEGATE_B_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(NEGATE_B_OBJ_FILES)

include $(MAKEFILE_RULES)
