HEX_FILES=\
	CosineTest.hex \
	AllCosineTest.hex \
	CosineWhenIdleTest.hex \
	CosineWhenNotIdleTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../InitialiseAfterCordicDummy.o \
	../PollAfterCordicDummy.o

COSINE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	CosineTest.o

ALL_COSINE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	../AllCordicSpaceTestFixture.o \
	AllCosineTest.o

COSINE_WHEN_IDLE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	CosineWhenIdleTest.o

COSINE_WHEN_NOT_IDLE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	CosineWhenNotIdleTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

CosineTest.hex: $(OBJ_FILES) $(COSINE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(COSINE_OBJ_FILES)

AllCosineTest.hex: $(OBJ_FILES) $(ALL_COSINE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ALL_COSINE_OBJ_FILES)

CosineWhenIdleTest.hex: $(OBJ_FILES) $(COSINE_WHEN_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(COSINE_WHEN_IDLE_OBJ_FILES)

CosineWhenNotIdleTest.hex: $(OBJ_FILES) $(COSINE_WHEN_NOT_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(COSINE_WHEN_NOT_IDLE_OBJ_FILES)

include $(MAKEFILE_RULES)
