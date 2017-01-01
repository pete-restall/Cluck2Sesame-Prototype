HEX_FILES=\
	ArcSineTest.hex \
	AllArcSineTest.hex \
	ArcSineWhenIdleTest.hex \
	ArcSineWhenNotIdleTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../InitialiseAfterCordicDummy.o \
	../PollAfterCordicDummy.o

ARC_SINE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	ArcSineTest.o

ALL_ARC_SINE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	../AllCordicSpaceTestFixture.o \
	AllArcSineTest.o

ARC_SINE_WHEN_IDLE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	ArcSineWhenIdleTest.o

ARC_SINE_WHEN_NOT_IDLE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	ArcSineWhenNotIdleTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ArcSineTest.hex: $(OBJ_FILES) $(ARC_SINE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ARC_SINE_OBJ_FILES)

AllArcSineTest.hex: $(OBJ_FILES) $(ALL_ARC_SINE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ALL_ARC_SINE_OBJ_FILES)

ArcSineWhenIdleTest.hex: $(OBJ_FILES) $(ARC_SINE_WHEN_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ARC_SINE_WHEN_IDLE_OBJ_FILES)

ArcSineWhenNotIdleTest.hex: $(OBJ_FILES) $(ARC_SINE_WHEN_NOT_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ARC_SINE_WHEN_NOT_IDLE_OBJ_FILES)

include $(MAKEFILE_RULES)
