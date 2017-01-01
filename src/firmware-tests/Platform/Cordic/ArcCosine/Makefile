HEX_FILES=\
	ArcCosineTest.hex \
	AllArcCosineTest.hex \
	ArcCosineWhenIdleTest.hex \
	ArcCosineWhenNotIdleTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../InitialiseAfterCordicDummy.o \
	../PollAfterCordicDummy.o

ARC_COSINE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	ArcCosineTest.o

ALL_ARC_COSINE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	../AllCordicSpaceTestFixture.o \
	AllArcCosineTest.o

ARC_COSINE_WHEN_IDLE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	ArcCosineWhenIdleTest.o

ARC_COSINE_WHEN_NOT_IDLE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	ArcCosineWhenNotIdleTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ArcCosineTest.hex: $(OBJ_FILES) $(ARC_COSINE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ARC_COSINE_OBJ_FILES)

AllArcCosineTest.hex: $(OBJ_FILES) $(ALL_ARC_COSINE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ALL_ARC_COSINE_OBJ_FILES)

ArcCosineWhenIdleTest.hex: $(OBJ_FILES) $(ARC_COSINE_WHEN_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ARC_COSINE_WHEN_IDLE_OBJ_FILES)

ArcCosineWhenNotIdleTest.hex: $(OBJ_FILES) $(ARC_COSINE_WHEN_NOT_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ARC_COSINE_WHEN_NOT_IDLE_OBJ_FILES)

include $(MAKEFILE_RULES)
