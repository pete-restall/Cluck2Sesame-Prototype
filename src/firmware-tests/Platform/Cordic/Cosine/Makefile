HEX_FILES=\
	CosineTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../InitialiseAfterCordicDummy.o \
	../PollAfterCordicDummy.o

COSINE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	CosineTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

CosineTest.hex: $(OBJ_FILES) $(COSINE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(COSINE_OBJ_FILES)

include $(MAKEFILE_RULES)
