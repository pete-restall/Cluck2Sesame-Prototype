HEX_FILES=\
	SineTest.hex \
	AllSineTest.hex \
	SineWhenIdleTest.hex \
	SineWhenNotIdleTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../InitialiseAfterCordicDummy.o \
	../PollAfterCordicDummy.o

SINE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	SineTest.o

ALL_SINE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	../AllCordicSpaceTestFixture.o \
	AllSineTest.o

SINE_WHEN_IDLE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	SineWhenIdleTest.o

SINE_WHEN_NOT_IDLE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	SineWhenNotIdleTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

SineTest.hex: $(OBJ_FILES) $(SINE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SINE_OBJ_FILES)

AllSineTest.hex: $(OBJ_FILES) $(ALL_SINE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ALL_SINE_OBJ_FILES)

SineWhenIdleTest.hex: $(OBJ_FILES) $(SINE_WHEN_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SINE_WHEN_IDLE_OBJ_FILES)

SineWhenNotIdleTest.hex: $(OBJ_FILES) $(SINE_WHEN_NOT_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SINE_WHEN_NOT_IDLE_OBJ_FILES)

include $(MAKEFILE_RULES)
