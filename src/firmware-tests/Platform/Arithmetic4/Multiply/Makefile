HEX_FILES=\
	Mul4x4Test.hex

MUL4X4_OBJ_FILES=\
	Mul4x4Test.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

Mul4x4Test.hex: $(OBJ_FILES) $(MUL4X4_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(MUL4X4_OBJ_FILES)

include $(MAKEFILE_RULES)
